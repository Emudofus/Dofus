package com.ankamagames.dofus.modules.utils
{
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   
   public class SpellTooltipSettings extends Object implements IModuleUtil
   {
      
      public function SpellTooltipSettings() {
         super();
         this._header = true;
         this._effects = true;
         this._description = true;
         this._CC_EC = true;
      }
      
      private var _header:Boolean;
      
      private var _effects:Boolean;
      
      private var _description:Boolean;
      
      private var _CC_EC:Boolean;
      
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
      
      public function get description() : Boolean {
         return this._description;
      }
      
      public function set description(value:Boolean) : void {
         this._description = value;
      }
      
      public function get CC_EC() : Boolean {
         return this._CC_EC;
      }
      
      public function set CC_EC(value:Boolean) : void {
         this._CC_EC = value;
      }
   }
}
