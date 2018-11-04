// Copyright 2016 Joe Wilm, The Alacritty Project Contributors
//
// Licensed under the Apache License, Version 2.0 (the "License"); // you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
#version 330 core
layout (location = 0) in vec2 position;

// Cell properties
layout (location = 1) in vec2 gridCoords;

// glyph properties
layout (location = 2) in vec4 glyph;

// uv mapping
layout (location = 3) in vec4 uv;

// text fg color
layout (location = 4) in vec3 textColor;
// Background color
layout (location = 5) in vec4 backgroundColor;

out vec2 TexCoords;
out vec3 fg;
out vec4 bg;

// Terminal properties
uniform vec2 termDim;
uniform vec2 cellDim;

uniform float visualBell;
uniform int backgroundPass;

// Orthographic projection
uniform mat4 projection;
flat out float vb;
flat out int background;

vec3 hslToRgb(vec3 c){return mix(c.bbb,mix(clamp(vec3(-1,2,2)-abs(c.r-vec3(3,2,4))*vec3(-1,1,1),0.,1.),vec3(c.b>.5),abs(.5-c.b)*2.),c.g);}
vec3 rgbToHsl(vec3 color) {
  vec3 hsl; // init to 0 to avoid warnings ? (and reverse if + remove first part)

  float fmin = min(min(color.r, color.g), color.b); //Min. value of RGB
  float fmax = max(max(color.r, color.g), color.b); //Max. value of RGB
  float delta = fmax - fmin; //Delta RGB value

  hsl.z = (fmax + fmin) / 2.0; // Luminance

  if (delta == 0.0) //This is a gray, no chroma...
  {
    hsl.x = 0.0;  // Hue
    hsl.y = 0.0;  // Saturation
  } else //Chromatic data...
  {
    if (hsl.z < 0.5)
    hsl.y = delta / (fmax + fmin); // Saturation
    else
    hsl.y = delta / (2.0 - fmax - fmin); // Saturation
    
    float deltaR = (((fmax - color.r) / 6.0) + (delta / 2.0)) / delta;
    float deltaG = (((fmax - color.g) / 6.0) + (delta / 2.0)) / delta;
    float deltaB = (((fmax - color.b) / 6.0) + (delta / 2.0)) / delta;
    
    if (color.r == fmax )
    hsl.x = deltaB - deltaG; // Hue
    else if (color.g == fmax)
    hsl.x = (1.0 / 3.0) + deltaR - deltaB; // Hue
    else if (color.b == fmax)
    hsl.x = (2.0 / 3.0) + deltaG - deltaR; // Hue
    
    if (hsl.x < 0.0)
    hsl.x += 1.0; // Hue
    else if (hsl.x > 1.0)
    hsl.x -= 1.0; // Hue
  }

  return hsl;
}

vec3 tweak(vec3 rgb) {
  vec3 hsl = rgbToHsl(rgb);
  hsl.x *= 6; 
  return hslToRgb(hsl);
}

void main()
{
    vec2 glyphOffset = glyph.xy;
    vec2 glyphSize = glyph.zw;
    vec2 uvOffset = uv.xy;
    vec2 uvSize = uv.zw;

    // Position of cell from top-left
    vec2 cellPosition = (cellDim) * gridCoords;

    // Invert Y since framebuffer origin is bottom-left
    cellPosition.y = termDim.y - cellPosition.y - cellDim.y;

    if (backgroundPass != 0) {
        cellPosition.y = cellPosition.y;
        vec2 finalPosition = cellDim * position + cellPosition;
        gl_Position = projection * vec4(finalPosition.xy, 0.0, 1.0);
        TexCoords = vec2(0, 0);
    } else {
        // Glyphs are offset within their cell; account for y-flip
        vec2 cellOffset = vec2(glyphOffset.x, glyphOffset.y - glyphSize.y);

        // position coordinates are normalized on [0, 1]
        vec2 finalPosition = glyphSize * position + cellPosition + cellOffset;

        gl_Position = projection * vec4(finalPosition.xy, 0.0, 1.0);
        TexCoords = uvOffset + vec2(position.x, 1 - position.y) * uvSize;
    }

    vb = visualBell;
    background = backgroundPass;

    bg = vec4(tweak(backgroundColor.rgb / 255.0), backgroundColor.a);
    fg = tweak(textColor / 255.0);
}
