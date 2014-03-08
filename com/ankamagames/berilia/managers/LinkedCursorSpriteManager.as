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
      
      public function getItem(name:String) : LinkedCursorData {
         return this.items[name];
      }
      
      public function addItem(name:String, item:LinkedCursorData, overAll:Boolean=false) : void {
         this._mustBeRemoved[name] = false;
         if(this.items[name])
         {
            this.removeItem(name);
         }
         this.items[name] = item;
         item.sprite.mouseChildren = false;
         item.sprite.mouseEnabled = false;
         if(overAll)
         {
            Berilia.getInstance().strataSuperTooltip.addChild(item.sprite);
         }
         else
         {
            Berilia.getInstance().strataTooltip.addChild(item.sprite);
         }
         var fmouseX:* = StageShareManager.mouseX;
         var fmouseY:* = StageShareManager.mouseY;
         item.sprite.x = (item.lockX?item.sprite.x:StageShareManager.mouseX) - (item.offset?item.offset.x:item.sprite.width / 2);
         item.sprite.y = (item.lockY?item.sprite.y:StageShareManager.mouseY) - (item.offset?item.offset.y:item.sprite.height / 2);
         if((item.lockX) || (item.lockY))
         {
         }
         this.updateCursors();
         EnterFrameDispatcher.addEventListener(this.updateCursors,"updateCursors");
      }
      
      public function removeItem(name:String, asynch:Boolean=false) : Boolean {
         if(!this.items[name])
         {
            return false;
         }
         this._mustBeRemoved[name] = true;
         if(asynch)
         {
            this._mustClean = true;
            EnterFrameDispatcher.addEventListener(this.updateCursors,"updateCursors");
         }
         else
         {
            this.remove(name);
         }
         return true;
      }
      
      private function updateCursors(e:*=null) : void {
         var item:LinkedCursorData = null;
         var cursorName:String = null;
         if(this._mustClean)
         {
            this._mustClean = false;
            for (cursorName in this._mustBeRemoved)
            {
               if((this._mustBeRemoved[cursorName]) && (this.items[cursorName]))
               {
                  this.remove(cursorName);
               }
            }
         }
         var xMouse:int = StageShareManager.mouseX;
         var yMouse:int = StageShareManager.mouseY;
         for each (item in this.items)
         {
            if(item)
            {
               if(!item.lockX)
               {
                  item.sprite.x = xMouse + (item.offset?item.offset.x:0);
               }
               if(!item.lockY)
               {
                  item.sprite.y = yMouse + (item.offset?item.offset.y:0);
               }
            }
         }
      }
      
      private function remove(name:String) : void {
         var o:Object = null;
         var s:DisplayObject = this.items[name].sprite as DisplayObject;
         if(s.parent)
         {
            s.parent.removeChild(s);
         }
         this.items[name] = null;
         delete this.items[[name]];
         delete this._mustBeRemoved[[name]];
         var empty:Boolean = true;
         for (o in this.items)
         {
            empty = false;
         }
         if(empty)
         {
            EnterFrameDispatcher.removeEventListener(this.updateCursors);
         }
      }
   }
}
