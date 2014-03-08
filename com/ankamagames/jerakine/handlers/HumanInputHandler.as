package com.ankamagames.jerakine.handlers
{
   import com.ankamagames.jerakine.messages.MessageDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.prng.ParkMillerCarta;
   import flash.display.Stage;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.pools.GenericPool;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMiddleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import flash.ui.Keyboard;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class HumanInputHandler extends MessageDispatcher
   {
      
      public function HumanInputHandler() {
         this._debugOverSprite = new Dictionary(true);
         super();
         if(_self != null)
         {
            throw new SingletonError("HumanInputHandler constructor should not be called directly.");
         }
         else
         {
            this.initialize();
            return;
         }
      }
      
      private static var _self:HumanInputHandler;
      
      private static const DOUBLE_CLICK_DELAY:uint = 500;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HumanInputHandler));
      
      public static function getInstance() : HumanInputHandler {
         if(_self == null)
         {
            _self = new HumanInputHandler();
         }
         return _self;
      }
      
      private var _handler:MessageHandler;
      
      private var _keyPoll:KeyPoll;
      
      private var _lastTarget:WeakReference;
      
      private var _lastDoucleClick:int;
      
      private var _lastSingleClick:int;
      
      private var _appleDown:Boolean;
      
      private var _appleKeyboardEvent:KeyboardEvent;
      
      private var _debugOver:Boolean = false;
      
      private var _debugOverSprite:Dictionary;
      
      private const random:ParkMillerCarta = new ParkMillerCarta();
      
      public function get debugOver() : Boolean {
         return this._debugOver;
      }
      
      public function set debugOver(param1:Boolean) : void {
         var _loc2_:* = undefined;
         if((this._debugOver) && !param1)
         {
            for (_loc2_ in this._debugOverSprite)
            {
               if(_loc2_.parent)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
            }
            this._debugOverSprite = new Dictionary();
         }
         this._debugOver = param1;
      }
      
      public function get handler() : MessageHandler {
         return this._handler;
      }
      
      public function set handler(param1:MessageHandler) : void {
         this._handler = param1;
      }
      
      public function getKeyboardPoll() : KeyPoll {
         return this._keyPoll;
      }
      
      public function resetClick() : void {
         this._lastTarget = null;
      }
      
      private function initialize() : void {
         this._keyPoll = new KeyPoll();
         this.registerListeners();
      }
      
      public function unregisterListeners(param1:Stage=null) : void {
         var target:Stage = param1;
         if(target == null)
         {
            target = StageShareManager.stage;
         }
         target.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick,true);
         target.removeEventListener(MouseEvent.CLICK,this.onClick,true);
         target.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true);
         target.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,true);
         target.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,true);
         target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,true);
         target.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,true);
         try
         {
            target.removeEventListener(MouseEvent.MIDDLE_CLICK,this.onMiddleClick,true);
            target.removeEventListener(MouseEvent.RIGHT_CLICK,this.onRightClick,true);
         }
         catch(e:TypeError)
         {
            _log.error("RIGHT_CLICK / MIDDLE_CLICK non supporté");
         }
         target.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false);
         target.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false);
      }
      
      public function registerListeners(param1:Stage=null) : void {
         var target:Stage = param1;
         if(target == null)
         {
            target = StageShareManager.stage;
         }
         target.addEventListener(MouseEvent.DOUBLE_CLICK,this.onDoubleClick,true,1,true);
         target.addEventListener(MouseEvent.CLICK,this.onClick,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheel,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,true,1,true);
         target.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,true,1,true);
         try
         {
            target.addEventListener(MouseEvent.MIDDLE_CLICK,this.onMiddleClick,true,1,true);
            target.addEventListener(MouseEvent.RIGHT_CLICK,this.onRightClick,true,1,true);
         }
         catch(e:TypeError)
         {
            _log.error("RIGHT_CLICK / MIDDLE_CLICK non supporté");
         }
         target.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,1,true);
         target.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,1,true);
      }
      
      private function onDoubleClick(param1:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseDoubleClickMessage,param1.target,param1));
         this._lastDoucleClick = getTimer();
      }
      
      private function onClick(param1:MouseEvent) : void {
         var _loc2_:int = getTimer();
         if(_loc2_ - this._lastDoucleClick < DOUBLE_CLICK_DELAY)
         {
            this._lastSingleClick = _loc2_;
            this._lastDoucleClick = 0;
         }
         else
         {
            if(_loc2_ - this._lastSingleClick < DOUBLE_CLICK_DELAY)
            {
               this._handler.process(GenericPool.get(MouseDoubleClickMessage,param1.target,param1));
               this._lastDoucleClick = _loc2_;
            }
            else
            {
               this._handler.process(GenericPool.get(MouseClickMessage,param1.target,param1));
            }
         }
      }
      
      private function onMouseWheel(param1:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseWheelMessage,param1.target,param1));
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         var _loc2_:DisplayObject = null;
         var _loc3_:String = null;
         var _loc4_:Sprite = null;
         var _loc5_:* = false;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Rectangle = null;
         if((this.debugOver) && (param1.target.parent))
         {
            _loc2_ = param1.target as DisplayObject;
            _loc3_ = "#{{{debug_shape_" + _loc2_.name + "}}}#";
            _loc5_ = false;
            _loc6_ = 0;
            while(_loc6_ < _loc2_.parent.numChildren && !_loc5_)
            {
               if(_loc2_.parent.getChildAt(_loc6_).name == _loc3_)
               {
                  _loc4_ = _loc2_.parent.getChildAt(_loc6_) as Sprite;
                  break;
               }
               _loc6_++;
            }
            _loc7_ = 1;
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc7_ = _loc7_ + _loc3_.charCodeAt(_loc8_) * 100 * _loc8_;
               _loc8_++;
            }
            this.random.seed(_loc7_);
            if(!_loc4_)
            {
               _loc4_ = new Sprite();
               _loc4_.mouseEnabled = false;
               _loc4_.mouseChildren = false;
            }
            this._debugOverSprite[_loc4_] = true;
            _loc4_.name = _loc3_;
            _loc4_.graphics.clear();
            _loc9_ = _loc2_.getBounds(_loc2_.parent);
            _loc4_.graphics.beginFill(this.random.nextInt(),0.4);
            _loc4_.graphics.lineStyle(1,0,0.5);
            _loc4_.graphics.drawRect(_loc9_.left,_loc9_.top,_loc9_.width,_loc9_.height);
            _loc4_.graphics.endFill();
            _loc2_.parent.addChildAt(_loc4_,_loc2_.parent.getChildIndex(_loc2_) + 1);
         }
         this._handler.process(GenericPool.get(MouseOverMessage,param1.target,param1));
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseOutMessage,param1.target,param1));
      }
      
      private function onMiddleClick(param1:MouseEvent) : void {
         this._handler.process(GenericPool.get(MouseMiddleClickMessage,param1.target,param1));
      }
      
      private function onRightClick(param1:MouseEvent) : void {
         if(!(this._lastTarget == null) && !(this._lastTarget.object == param1.target))
         {
            this._handler.process(GenericPool.get(MouseRightClickOutsideMessage,this._lastTarget.object,param1));
         }
         this._lastTarget = new WeakReference(param1.target);
         this._handler.process(GenericPool.get(MouseRightClickMessage,param1.target,param1));
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         this._lastTarget = new WeakReference(param1.target);
         this._handler.process(GenericPool.get(MouseDownMessage,param1.target,param1));
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         if(!(this._lastTarget == null) && !(this._lastTarget.object == param1.target))
         {
            this._handler.process(GenericPool.get(MouseReleaseOutsideMessage,this._lastTarget.object,param1));
         }
         FocusHandler.getInstance().setFocus(InteractiveObject(param1.target));
         this._handler.process(GenericPool.get(MouseUpMessage,param1.target,param1));
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            param1.preventDefault();
         }
         if(param1.keyCode == 15)
         {
            this._appleDown = true;
         }
         if(param1.keyCode == Keyboard.S && (param1.ctrlKey))
         {
            param1.preventDefault();
         }
         this._handler.process(GenericPool.get(KeyboardKeyDownMessage,FocusHandler.getInstance().getFocus(),param1));
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void {
         if(!this._appleDown)
         {
            this._handler.process(GenericPool.get(KeyboardKeyUpMessage,FocusHandler.getInstance().getFocus(),param1));
         }
         else
         {
            this._appleDown = false;
         }
      }
   }
}
