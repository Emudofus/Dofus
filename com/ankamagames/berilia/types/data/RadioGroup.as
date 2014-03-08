package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.interfaces.IRadioItem;
   
   public class RadioGroup extends Object
   {
      
      public function RadioGroup(param1:String) {
         super();
         this.name = param1;
         this._items = new Array();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RadioGroup));
      
      private var _items:Array;
      
      private var _selected:IRadioItem;
      
      public var name:String;
      
      public function addItem(param1:IRadioItem) : void {
         this._items[param1.id] = param1;
         if(param1.selected)
         {
            this._selected = param1;
         }
      }
      
      public function removeItem(param1:IRadioItem) : void {
         delete this._items[[param1.id]];
      }
      
      public function destroy() : void {
         this._items = null;
         this._selected = null;
      }
      
      public function get value() : * {
         if(this._selected)
         {
            return this._selected.value;
         }
         return null;
      }
      
      public function set value(param1:*) : void {
         var _loc2_:IRadioItem = null;
         for each (_loc2_ in this._items)
         {
            if(_loc2_.value == param1)
            {
               this.selectedItem = _loc2_;
            }
         }
      }
      
      public function set selectedItem(param1:IRadioItem) : void {
         var _loc2_:IRadioItem = null;
         if(this._selected == param1)
         {
            return;
         }
         for each (_loc2_ in this._items)
         {
            if(_loc2_.selected != param1 == _loc2_)
            {
               _loc2_.selected = param1 == _loc2_;
            }
         }
         this._selected = param1;
      }
      
      public function get selectedItem() : IRadioItem {
         return this._selected;
      }
   }
}
