package com.ankamagames.dofus.modules.utils
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   
   public class ItemTooltipSettings extends Object implements IModuleUtil
   {
      
      public function ItemTooltipSettings() {
         super();
         this._header = true;
         this._effects = true;
         this._conditions = true;
         this._description = true;
         this._averagePrice = true;
      }
      
      private var _header:Boolean;
      
      private var _effects:Boolean;
      
      private var _conditions:Boolean;
      
      private var _description:Boolean;
      
      private var _averagePrice:Boolean;
      
      public function get header() : Boolean {
         return this._header;
      }
      
      public function set header(value:Boolean) : void {
         this._header = value;
      }
      
      public function get effects() : Boolean {
         return this._effects;
      }
      
      public function set effects(value:Boolean) : void {
         this._effects = value;
      }
      
      public function get conditions() : Boolean {
         return this._conditions;
      }
      
      public function set conditions(value:Boolean) : void {
         this._conditions = value;
      }
      
      public function get description() : Boolean {
         return this._description;
      }
      
      public function set description(value:Boolean) : void {
         this._description = value;
      }
      
      public function get averagePrice() : Boolean {
         return this._averagePrice;
      }
      
      public function set averagePrice(value:Boolean) : void {
         this._averagePrice = value;
      }
   }
}
