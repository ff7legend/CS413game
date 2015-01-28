

import starling.display.Sprite;
import starling.utils.AssetManager;
import starling.display.Image;
import starling.core.Starling;
import starling.animation.Transitions;
import starling.events.KeyboardEvent;
import flash.ui.Keyboard;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

class Root extends Sprite {



    public static var assets:AssetManager;
    public var heads:Image;
    public var tails:Image;
    public var BG: Image;

    
  	

    public function new() {
        super();
    }

    public function start(startup:Startup) {
    

        assets = new AssetManager();
	
		assets.enqueue("assets/BG.png");
		assets.enqueue("assets/tails.png");
        assets.enqueue("assets/heads.png");
        
        assets.loadQueue(function onProgress(ratio:Int) {
		
            if (ratio == 1) {
	
                Starling.juggler.tween(startup.loadingBitmap, 2.0, {
                    transition: Transitions.EASE_OUT,
                        delay: 1.0,
                        alpha: 0,
                        onComplete: function() {
                        startup.removeChild(startup.loadingBitmap);
                        
                    	BG = new Image(Root.assets.getTexture("BG"));
                    	addChild(BG);
						
                       
                        var ranNum:Float;
                       	ranNum = Math.round(Math.random());
                       	
                        if(ranNum%2 == 1){
                        	heads = new Image(Root.assets.getTexture("tails"));
                       	 	addChild(heads);
                        	heads.x = 250;
                        	heads.y = 0;
                        }else{

                        	heads = new Image(Root.assets.getTexture("heads"));
                       	 	addChild(heads);
                        	heads.x = 250;
                        	heads.y = 0;
                        }
                        
                        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, 
                        	function(event:KeyboardEvent){
                        		trace(event.keyCode);
                        		if(event.keyCode == Keyboard.LEFT){
                        			heads.x -= 10;
                        			}
                        		
                        		if(event.keyCode == Keyboard.RIGHT){
                        			heads.x += 10;
                        			}
                        	});
                        	
                        	heads.addEventListener(TouchEvent.TOUCH, 
                        	function(e:TouchEvent){
                        		var touch = e.getTouch(stage, TouchPhase.BEGAN);
                        		trace("heads TOUCHED");
                        		
                        	});

                        Starling.juggler.tween(heads, 1.0, {
                            transition: Transitions.EASE_OUT_BOUNCE,
                                delay: 2.0,
                                y: 250
                                });

                    }

                });
            }

        });
    }

}
