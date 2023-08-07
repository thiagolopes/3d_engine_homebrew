#shader vertex
#version 330 core

layout(location = 0) in vec3 position;
layout(location = 1) in vec2 texCoord;

out vec2 v_TexCoord;

// MODEL VIEW PROJECTION
uniform mat4 u_M;
uniform mat4 u_V;
uniform mat4 u_P;

void main(){
    gl_Position =  u_P * u_V * u_M * vec4(position, 1.0);
    v_TexCoord = texCoord;
}

//-----------------------------------------------------------------------------
#shader fragment
#version 330 core

layout(location = 0) out vec4 fragColor;

float character(int n, vec2 p)
{
    p = floor(p*vec2(-4.0, 4.0) + 2.5);
    if (clamp(p.x, 0.0, 4.0) == p.x)
    {
        if (clamp(p.y, 0.0, 4.0) == p.y)
        {
            int a = int(round(p.x) + 5.0 * round(p.y));
            if (((n >> a) & 1) == 1) return 1.0;
        }
    }
    return 0.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 pix = fragCoord.xy;
    vec3 col = texture(iChannel0, floor(pix/8.0)*8.0/iResolution.xy).rgb;

    float gray = 0.3 * col.r + 0.59 * col.g + 0.11 * col.b;

    int n =  4096;

    // limited character set
    if (gray > 0.2) n = 65600;    // :
    if (gray > 0.3) n = 163153;   // *
    if (gray > 0.4) n = 15255086; // o
    if (gray > 0.5) n = 13121101; // &
    if (gray > 0.6) n = 15252014; // 8
    if (gray > 0.7) n = 13195790; // @
    if (gray > 0.8) n = 11512810; // #

    // full character set including A-Z and 0-9
    /*
    if (gray > 0.0233) n = 4096;
    if (gray > 0.0465) n = 131200;
    if (gray > 0.0698) n = 4329476;
    if (gray > 0.0930) n = 459200;
    if (gray > 0.1163) n = 4591748;
    if (gray > 0.1395) n = 12652620;
    if (gray > 0.1628) n = 14749828;
    if (gray > 0.1860) n = 18393220;
    if (gray > 0.2093) n = 15239300;
    if (gray > 0.2326) n = 17318431;
    if (gray > 0.2558) n = 32641156;
    if (gray > 0.2791) n = 18393412;
    if (gray > 0.3023) n = 18157905;
    if (gray > 0.3256) n = 17463428;
    if (gray > 0.3488) n = 14954572;
    if (gray > 0.3721) n = 13177118;
    if (gray > 0.3953) n = 6566222;
    if (gray > 0.4186) n = 16269839;
    if (gray > 0.4419) n = 18444881;
    if (gray > 0.4651) n = 18400814;
    if (gray > 0.4884) n = 33061392;
    if (gray > 0.5116) n = 15255086;
    if (gray > 0.5349) n = 32045584;
    if (gray > 0.5581) n = 18405034;
    if (gray > 0.5814) n = 15022158;
    if (gray > 0.6047) n = 15018318;
    if (gray > 0.6279) n = 16272942;
    if (gray > 0.6512) n = 18415153;
    if (gray > 0.6744) n = 32641183;
    if (gray > 0.6977) n = 32540207;
    if (gray > 0.7209) n = 18732593;
    if (gray > 0.7442) n = 18667121;
    if (gray > 0.7674) n = 16267326;
    if (gray > 0.7907) n = 32575775;
    if (gray > 0.8140) n = 15022414;
    if (gray > 0.8372) n = 15255537;
    if (gray > 0.8605) n = 32032318;
    if (gray > 0.8837) n = 32045617;
    if (gray > 0.9070) n = 33081316;
    if (gray > 0.9302) n = 32045630;
    if (gray > 0.9535) n = 33061407;
    if (gray > 0.9767) n = 11512810;
    */

    vec2 p = mod(pix/4.0, 2.0) - vec2(1.0);

    if (iMouse.z > 0.5)	col = vec3(character(n, p));
    else col = col*character(n, p);

    fragColor = vec4(col, 1.0);
}
