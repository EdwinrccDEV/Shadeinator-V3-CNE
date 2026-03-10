/*
  ______                                
 /      \                               
|  $$$$$$\ ________   ______    ______  
| $$__| $$|        \ /      \  /      \ 
| $$    $$ \$$$$$$$$|  $$$$$$\|  $$$$$$\
| $$$$$$$$  /    $$ | $$    $$| $$   \$$
| $$  | $$ /  $$$$_ | $$$$$$$$| $$      
| $$  | $$|  $$    \ \$$     \| $$      
 \$$   \$$ \$$$$$$$$  \$$$$$$$ \$$      
                                        
Shader Example                                        

*/

var rtx:CustomShader;
rtx = new CustomShader("RTXLighting");

function create() {
    rtx.overlayColor = [0.0, 0.0, 0.0, 1.0]; 

    rtx.satinColor = [0.37, 0.46, 0.67, 1.0]; 

    rtx.innerShadowColor = [0.0, 0.61, 0.74, 1.0];
    rtx.innerShadowAngle = -1.57; 
    rtx.innerShadowDistance = 8.0;
    
    rtx.layernumbers = 3.0; 
    rtx.layerseparation = 4.0;

    dad.shader = rtx; 
    bf.shader = rtx; 
    gf.shader = rtx;
}