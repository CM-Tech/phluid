precision mediump float;

uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
uniform sampler2D backbuffer;

float noise(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,4.1414))) * 43758.5453);
}

vec3 neighbour(vec2 offset) {
  return vec3(greaterThan(texture2D(backbuffer, (gl_FragCoord.xy+offset)/resolution).rgb, vec3(0.0)));
}

void main() {
  if(time>1.0){
    if (distance(mouse, gl_FragCoord.xy) < 20.0) {
      gl_FragColor = vec4(1.0);
    } else {
      vec3 neighbours = neighbour(vec2(-1.,-1.))
                      + neighbour(vec2(-1., 0.))
                      + neighbour(vec2(-1., 1.))
                      + neighbour(vec2( 0.,-1.))
                      + neighbour(vec2( 0., 1.))
                      + neighbour(vec2( 1.,-1.))
                      + neighbour(vec2( 1., 0.))
                      + neighbour(vec2( 1., 1.));

      vec3 current = texture2D(backbuffer, gl_FragCoord.xy/resolution).rgb;

      vec3 live = vec3(greaterThan(current, vec3(0.0)));
      current += (1.0-live) * vec3(equal(neighbours, vec3(3.0)));
      current *= vec3(equal(neighbours, vec3(2.0))) + vec3(equal(neighbours, vec3(3.0)));
      current -= vec3(greaterThan(current, vec3(0.4)))*0.05;

      gl_FragColor = vec4(current, 1.0);
    }
  }else {
    gl_FragColor = vec4(noise(gl_FragCoord.xy) > 0.8 ? 1.0 : 0.0);
  }
}
