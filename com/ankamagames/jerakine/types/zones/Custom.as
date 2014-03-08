package com.ankamagames.jerakine.types.zones
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   
   public class Custom extends Object implements IZone
   {
      
      public function Custom(param1:Vector.<uint>) {
         super();
         this._aCells = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Custom));
      
      private var _aCells:Vector.<uint>;
      
      public function get radius() : uint {
         return null;
      }
      
      public function set radius(param1:uint) : void {
      }
      
      public function get surface() : uint {
         return this._aCells.length;
      }
      
      public function set minRadius(param1:uint) : void {
      }
      
      public function get minRadius() : uint {
         return null;
      }
      
      public function set direction(param1:uint) : void {
      }
      
      public function get direction() : uint {
         return null;
      }
      
      public function getCells(param1:uint=0) : Vector.<uint> {
         return this._aCells;
      }
   }
}
