package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.jerakine.interfaces.ICustomSecureObject;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import flash.geom.Point;
   import com.ankamagames.berilia.interfaces.IClonable;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import gs.TweenMax;
   import gs.easing.Quart;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.UIComponent;
   import gs.events.TweenEvent;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SlotGridRenderer extends Object implements IGridRenderer, ICustomSecureObject
   {
      
      public function SlotGridRenderer(strParams:String) {
         this._log = Log.getLogger(getQualifiedClassName(SlotGridRenderer));
         super();
         var params:Array = strParams?strParams.split(","):[];
         this._emptyTexture = (params[0]) && (params[0].length)?new Uri(params[0]):null;
         this._overTexture = (params[1]) && (params[1].length)?new Uri(params[1]):null;
         this._selectedTexture = (params[2]) && (params[2].length)?new Uri(params[2]):null;
         this._acceptDragTexture = (params[3]) && (params[3].length)?new Uri(params[3]):null;
         this._refuseDragTexture = (params[4]) && (params[4].length)?new Uri(params[4]):null;
         this._timerTexture = (params[5]) && (params[5].length)?new Uri(params[5]):null;
         this._cssUri = (params[6]) && (params[6].length)?new Uri(params[6]):null;
         this._allowDrop = (params[7]) && (params[7].length)?params[7] == "true":true;
         this._isButton = (params[8]) && (params[8].length)?params[8] == "true":false;
      }
      
      protected var _log:Logger;
      
      private var _grid:Grid;
      
      private var _emptyTexture:Uri;
      
      private var _overTexture:Uri;
      
      private var _selectedTexture:Uri;
      
      private var _acceptDragTexture:Uri;
      
      private var _refuseDragTexture:Uri;
      
      private var _customTexture:Uri;
      
      private var _timerTexture:Uri;
      
      private var _cssUri:Uri;
      
      private var _allowDrop:Boolean;
      
      private var _isButton:Boolean;
      
      private var _hideQuantities:Boolean = false;
      
      public var dropValidatorFunction:Function;
      
      public var processDropFunction:Function;
      
      public var removeDropSourceFunction:Function;
      
      public function set allowDrop(pAllow:Boolean) : void {
         this._allowDrop = pAllow;
      }
      
      public function get allowDrop() : Boolean {
         return this._allowDrop;
      }
      
      public function set isButton(pButton:Boolean) : void {
         this._isButton = pButton;
      }
      
      public function get isButton() : Boolean {
         return this._isButton;
      }
      
      public function set hideQuantities(value:Boolean) : void {
         this._hideQuantities = value;
      }
      
      public function get hideQuantities() : Boolean {
         return this._hideQuantities;
      }
      
      public function get acceptDragTexture() : Uri {
         return this._acceptDragTexture;
      }
      
      public function set acceptDragTexture(uri:Uri) : void {
         this._acceptDragTexture = uri;
      }
      
      public function get refuseDragTexture() : Uri {
         return this._refuseDragTexture;
      }
      
      public function set refuseDragTexture(uri:Uri) : void {
         this._refuseDragTexture = uri;
      }
      
      public function get customTexture() : Uri {
         return this._customTexture;
      }
      
      public function set customTexture(uri:Uri) : void {
         this._customTexture = uri;
      }
      
      public function set grid(g:Grid) : void {
         this._grid = g;
      }
      
      public function render(data:*, index:uint, selected:Boolean, subIndex:uint=0) : DisplayObject {
         var slotData:* = SecureCenter.unsecure(data);
         var slot:Slot = new Slot();
         slot.name = this._grid.getUi().name + "::" + this._grid.name + "::item" + index;
         slot.mouseEnabled = true;
         slot.emptyTexture = this._emptyTexture;
         slot.highlightTexture = this._overTexture;
         slot.timerTexture = this._timerTexture;
         slot.selectedTexture = this._selectedTexture;
         slot.acceptDragTexture = this._acceptDragTexture;
         slot.refuseDragTexture = this._refuseDragTexture;
         slot.customTexture = this._customTexture;
         slot.css = this._cssUri;
         slot.isButton = this._isButton;
         if(this._hideQuantities)
         {
            slot.hideTopLabel = true;
         }
         else
         {
            slot.hideTopLabel = false;
         }
         slot.width = this._grid.slotWidth;
         slot.height = this._grid.slotHeight;
         if(this._isButton)
         {
            slot.selected = selected;
         }
         else
         {
            slot.allowDrag = this._allowDrop;
         }
         slot.data = slotData;
         slot.processDrop = this._processDrop;
         slot.removeDropSource = this._removeDropSourceFunction;
         slot.dropValidator = this._dropValidatorFunction;
         slot.finalize();
         return slot;
      }
      
      public function _removeDropSourceFunction(target:*) : void {
         var data:* = undefined;
         if(this.removeDropSourceFunction != null)
         {
            this.removeDropSourceFunction(target);
            return;
         }
         var dp:Array = new Array();
         var addData:Boolean = true;
         for each (data in this._grid.dataProvider)
         {
            if(data != target.data)
            {
               dp.push(data);
            }
         }
         this._grid.dataProvider = dp;
      }
      
      public function _dropValidatorFunction(target:Object, iSlotData:*, source:Object) : Boolean {
         if(this.dropValidatorFunction != null)
         {
            return this.dropValidatorFunction(target,iSlotData,source);
         }
         return true;
      }
      
      public function update(data:*, index:uint, dispObj:DisplayObject, selected:Boolean, subIndex:uint=0) : void {
         var slot:Slot = null;
         if(dispObj is Slot)
         {
            slot = Slot(dispObj);
            slot.data = SecureCenter.unsecure(data) as ISlotData;
            if(!this._isButton)
            {
               slot.selected = selected;
               slot.allowDrag = this._allowDrop;
            }
            slot.isButton = this._isButton;
            if(this._hideQuantities)
            {
               slot.hideTopLabel = true;
            }
            else
            {
               slot.hideTopLabel = false;
            }
            slot.dropValidator = this._dropValidatorFunction;
            slot.removeDropSource = this._removeDropSourceFunction;
            slot.processDrop = this._processDrop;
         }
         else
         {
            this._log.warn("Can\'t update, " + dispObj.name + " is not a Slot component");
         }
      }
      
      public function getDataLength(data:*, selected:Boolean) : uint {
         return 1;
      }
      
      public function remove(dispObj:DisplayObject) : void {
         if((dispObj is Slot) && (dispObj.parent))
         {
            Slot(dispObj).remove();
         }
      }
      
      public function destroy() : void {
         this._grid = null;
         this._emptyTexture = null;
         this._overTexture = null;
         this._timerTexture = null;
         this._selectedTexture = null;
         this._acceptDragTexture = null;
         this._refuseDragTexture = null;
         this._customTexture = null;
         this._cssUri = null;
      }
      
      public function _processDrop(target:*, data:*, source:*) : void {
         var linkCursor:LinkedCursorData = null;
         var pt:Point = null;
         var tweenTarget:DisplayObject = null;
         if(this.processDropFunction != null)
         {
            this.processDropFunction(target,data,source);
            return;
         }
         var sameGrid:Boolean = false;
         if(DisplayObject(data.holder).parent != this._grid)
         {
            if(data is IClonable)
            {
               this._grid.dataProvider.push((data as IClonable).clone());
            }
            else
            {
               this._grid.dataProvider.push(data);
            }
            this._grid.dataProvider = this._grid.dataProvider;
         }
         else
         {
            sameGrid = true;
         }
         linkCursor = LinkedCursorSpriteManager.getInstance().getItem(Slot.DRAG_AND_DROP_CURSOR_NAME);
         if((sameGrid) || (!this._grid.indexIsInvisibleSlot(this._grid.dataProvider.length - 1)))
         {
            tweenTarget = DisplayObject(data.holder);
            pt = tweenTarget.localToGlobal(new Point(tweenTarget.x,tweenTarget.y));
            TweenMax.to(linkCursor.sprite,0.5,
               {
                  "x":pt.x,
                  "y":pt.y,
                  "alpha":0,
                  "ease":Quart.easeOut,
                  "onCompleteListener":this.onTweenEnd
               });
         }
         else
         {
            pt = this._grid.localToGlobal(new Point(this._grid.x,this._grid.y));
            linkCursor.sprite.stopDrag();
            TweenMax.to(linkCursor.sprite,0.5,
               {
                  "x":pt.x + this._grid.width / 2,
                  "y":pt.y + this._grid.height,
                  "alpha":0,
                  "scaleX":0.1,
                  "scaleY":0.1,
                  "ease":Quart.easeOut,
                  "onCompleteListener":this.onTweenEnd
               });
         }
      }
      
      public function renderModificator(childs:Array) : Array {
         return childs;
      }
      
      public function eventModificator(msg:Message, functionName:String, args:Array, target:UIComponent) : String {
         return functionName;
      }
      
      private function onTweenEnd(e:TweenEvent) : void {
         LinkedCursorSpriteManager.getInstance().removeItem(Slot.DRAG_AND_DROP_CURSOR_NAME);
      }
   }
}
