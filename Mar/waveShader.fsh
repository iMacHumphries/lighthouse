void main( void )
{
    
    highp float waveStrength = 0.004;
    vec4 val = texture2D(u_myTexture, v_tex_coord);
    
    vec2 distortion1 = (texture2D(u_dudvMap, vec2(v_tex_coord.x + u_moveFactor, v_tex_coord.y)).rg * 1.9 - 1.0) *waveStrength;
    vec2 distortion2 = (texture2D(u_dudvMap, vec2(-v_tex_coord.x + u_moveFactor, v_tex_coord.y + u_moveFactor)).rg * 1.9 - 1.0) *waveStrength;
    vec2 totalDistortion = distortion1 + distortion2;
    
    
    vec2 texCoords = v_tex_coord;
    texCoords += totalDistortion;
    texCoords = clamp(texCoords, 0.001, 0.999);
    
    vec4 newColor = texture2D(u_myTexture, texCoords);
    
    gl_FragColor = newColor;
}