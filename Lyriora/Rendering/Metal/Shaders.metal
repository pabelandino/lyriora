#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    float2 texCoord;
};

struct TextEffectUniforms {
    float time;
    float glitchStrength;
    float chromaticStrength;
    float glowStrength;
    float scanlineStrength;
};

vertex VertexOut lyricTextVertex(uint vertexID [[vertex_id]]) {
    const float2 positions[4] = {
        {-1.0, -1.0}, { 1.0, -1.0}, {-1.0,  1.0}, { 1.0,  1.0}
    };
    const float2 texCoords[4] = {
        {0.0, 1.0}, {1.0, 1.0}, {0.0, 0.0}, {1.0, 0.0}
    };

    VertexOut out;
    out.position = float4(positions[vertexID], 0.0, 1.0);
    out.texCoord = texCoords[vertexID];
    return out;
}

fragment float4 lyricTextFragment(
    VertexOut in [[stage_in]],
    texture2d<float> sourceTexture [[texture(0)]],
    constant TextEffectUniforms& uniforms [[buffer(0)]]
) {
    constexpr sampler textureSampler(mag_filter::linear, min_filter::linear);

    float2 uv = in.texCoord;
    float t = uniforms.time;

    // Horizontal glitch slices
    float sliceIndex = floor(uv.y * 28.0);
    float sliceNoise = sin(sliceIndex * 12.9898 + t * 18.0) * 43758.5453;
    float sliceFraction = fract(sliceNoise);
    float glitchGate = step(0.82, sliceFraction) * uniforms.glitchStrength;
    uv.x += (sliceFraction - 0.5) * 0.08 * glitchGate;

    float chroma = uniforms.chromaticStrength * (0.004 + 0.002 * sin(t * 3.5));
    float2 redUV = uv + float2(chroma, 0.0);
    float2 blueUV = uv - float2(chroma, 0.0);

    float4 center = sourceTexture.sample(textureSampler, uv);
    float4 redSample = sourceTexture.sample(textureSampler, redUV);
    float4 blueSample = sourceTexture.sample(textureSampler, blueUV);

    float4 color;
    color.r = redSample.r;
    color.g = center.g;
    color.b = blueSample.b;
    color.a = max(max(center.a, redSample.a), blueSample.a);

    // Simple bloom-ish glow from alpha
    float glow = 0.0;
    const int samples = 4;
    for (int i = 0; i < samples; i++) {
        float angle = float(i) * 1.5707963;
        float2 offset = float2(cos(angle), sin(angle)) * 0.0035;
        glow += sourceTexture.sample(textureSampler, uv + offset).a;
    }
    glow /= float(samples);
    color.rgb += glow * uniforms.glowStrength * float3(1.0, 0.85, 0.35);

    // Scanlines
    float scan = sin((uv.y + t * 0.35) * 220.0) * 0.5 + 0.5;
    color.rgb *= 1.0 - scan * uniforms.scanlineStrength * 0.08;

    return color;
}
