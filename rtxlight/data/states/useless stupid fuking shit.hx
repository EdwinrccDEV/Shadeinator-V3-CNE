import flixel.FlxSprite;
import flixel.FlxG;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;
import sys.io.File;
import sys.FileSystem;

function postCreate() {
    var sprite = new FlxSprite(0, 0);
    sprite.loadGraphic("images/chars/bf.png");
    sprite.animation.addByPrefix("idle", "idle0", 16, true);

    sprite.shader = new CustomShader("RTXLighting");
    sprite.shader.overlayColor = [1, 0, 0, 1];
    sprite.shader.satinColor = [0, 0, 0, 0];
    sprite.shader.innerShadowColor = [1, 0, 0, 1];
    sprite.shader.innerShadowAngle = (0 - 90) * Math.PI / 180;
    sprite.shader.innerShadowDistance = 10;
    sprite.shader.layernumbers = 5;
    sprite.shader.layerseparation = 1;
    
    // Add sprite to the game so it can be rendered
    add(sprite);
    
    var frameCount = sprite.animation.frames.length;
    var frameWidth = Std.int(sprite.frameWidth);
    var frameHeight = Std.int(sprite.frameHeight);
    
    var sheetWidth = frameWidth * frameCount;
    var sheetHeight = frameHeight;
    
    var finalSheet = new BitmapData(sheetWidth, sheetHeight, true, 0x00000000);
    
    // Render each frame
    var currentFrame = 0;
    var captureFrames = true;
    
    // Use a timer/counter to capture frames over multiple update cycles
    new FlxTimer().start(0.05, function(tmr:FlxTimer) {
        if (currentFrame < frameCount) {
            sprite.animation.frameIndex = currentFrame;
            
            // Force render and capture from camera buffer
            FlxG.camera.fill(0x00000000, true);
            sprite.draw();
            FlxG.camera.render();
            
            // Capture the rendered frame
            var screenshot = new BitmapData(frameWidth, frameHeight, true, 0x00000000);
            screenshot.draw(FlxG.camera.canvas, null, null, null, 
                new Rectangle(sprite.x, sprite.y, frameWidth, frameHeight), true);
            
            // Copy to final sheet
            finalSheet.copyPixels(
                screenshot,
                new Rectangle(0, 0, frameWidth, frameHeight),
                new Point(currentFrame * frameWidth, 0),
                null, null, true
            );
            
            screenshot.dispose();
            currentFrame++;
        } else {
            // All frames captured, now save
            remove(sprite);
            
            if (!FileSystem.exists("exports")) {
                FileSystem.createDirectory("exports");
            }
            
            var bytes:ByteArray = finalSheet.encode(finalSheet.rect, new PNGEncoderOptions());
            
            if (bytes != null && bytes.length > 0) {
                File.saveBytes("exports/bf_shader_spritesheet.png", bytes);
                trace("Spritesheet completo exportado con shader. 🚀☕ (" + bytes.length + " bytes)");
            } else {
                trace("Error: Failed to encode - trying PNG fallback");
                // Fallback: use lime.graphics.Image
                #if lime
                var image = lime.graphics.Image.fromBitmapData(finalSheet);
                var pngBytes = image.encode(lime.graphics.ImageFileFormat.PNG);
                File.saveBytes("exports/bf_shader_spritesheet.png", pngBytes);
                trace("Saved with Lime fallback!");
                #end
            }
            
            finalSheet.dispose();
        }
    }, frameCount + 1);
}