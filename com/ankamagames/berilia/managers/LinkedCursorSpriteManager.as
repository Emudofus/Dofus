package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class LinkedCursorSpriteManager extends Object
   {
      
      public function LinkedCursorSpriteManager() {
         this.items = new Array();
         this._mustBeRemoved = new Array();
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LinkedCursorSpriteManager));
      
      private static var _self:LinkedCursorSpriteManager;
      
      public static function getInstance() : LinkedCursorSpriteManager {
         if(!_self)
         {
            _self = new LinkedCursorSpriteManager();
         }
         return _self;
      }
      
      private var items:Array;
      
      private var _mustBeRemoved:Array;
      
      private var _mustClean:Boolean;
      
      public function getItem(param1:String) : LinkedCursorData {
         return this.items[param1];
      }
      
      public function addItem(param1:String, param2:LinkedCursorData, param3:Boolean=false) : void {
         this._mustBeRemoved[param1] = false;
         if(this.items[param1])
         {
            this.removeItem(param1);
         }
         this.items[param1] = param2;
         param2.sprite.mouseChildren = false;
         param2.sprite.mouseEnabled = false;
         if(param3)
         {
            Berilia.getInstance().strataSuperTooltip.addChild(param2.sprite);
         }
         else
         {
            Berilia.getInstance().strataTooltip.addChild(param2.sprite);
         }
         var _loc4_:* = StageShareManager.mouseX;
         var _loc5_:* = StageShareManager.mouseY;
         param2.sprite.x = (param2.lockX?param2.sprite.x:StageShareManager.mouseX) - (param2.offset?param2.offset.x:param2.sprite.width / 2);
         param2.sprite.y = (param2.lockY?param2.sprite.y:StageShareManager.mouseY) - (param2.offset?param2.offset.y:param2.sprite.height / 2);
         if((param2.lockX) || (param2.lockY))
         {
         }
         this.updateCursors();
         EnterFrameDispatcher.addEventListener(this.updateCursors,"updateCursors");
      }
      
      public function removeItem(param1:String, param2:Boolean=false) : Boolean {
         if(!this.items[param1])
         {
            return false;
         }
         this._mustBeRemoved[param1] = true;
         if(param2)
         {
            this._mustClean = true;
            EnterFrameDispatcher.addEventListener(this.updateCursors,"updateCursors");
         }
         else
         {
            this.remove(param1);
         }
         return true;
      }
      
      private function updateCursors(param1:*=null) : void {
         var _loc4_:LinkedCursorData = null;
         var _loc5_:String = null;
         if(this._mustClean)
         {
            this._mustClean = false;
            for (_loc5_ in this._mustBeRemoved)
            {
               if((this._mustBeRemoved[_loc5_]) && (this.items[_loc5_]))
               {
                  this.remove(_loc5_);
               }
            }
         }
         var _loc2_:int = StageShareManager.mouseX;
         var _loc3_:int = StageShareManager.mouseY;
         for each (_loc4_ in this.items)
         {
            if(_loc4_)
            {
               if(!_loc4_.lockX)
               {
                  _loc4_.sprite.x = _loc2_ + (_loc4_.offset?_loc4_.offset.x:0);
               }
               if(!_loc4_.lockY)
               {
                  _loc4_.sprite.y = _loc3_ + (_loc4_.offset?_loc4_.offset.y:0);
               }
            }
         }
      }
      
      private function remove(param1:String) : void {
         var _loc4_:Object = null;
         var _loc2_:DisplayObject = this.items[param1].sprite as DisplayObject;
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         this.items[param1] = null;
         delete this.items[[param1]];
         delete this._mustBeRemoved[[param1]];
         var _loc3_:* = true;
         for (_loc4_ in this.items)
         {
            _loc3_ = false;
         }
         if(_loc3_)
         {
            EnterFrameDispatcher.removeEventListener(this.updateCursors);
         }
      }
   }
}
