package com.ankamagames.atouin.types
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   
   public class GraphicCell extends Sprite implements ICustomUnicNameGetter
   {
      
      public function GraphicCell(param1:uint) {
         this._dropValidator = this.returnTrueFunction;
         this._removeDropSource = this.returnTrueFunction;
         this._processDrop = this.returnTrueFunction;
         super();
         this.cellId = param1;
         name = param1.toString();
         this._name = "cell::" + param1;
         buttonMode = true;
         mouseChildren = false;
         cacheAsBitmap = true;
      }
      
      private var _dropValidator:Function;
      
      private var _removeDropSource:Function;
      
      private var _processDrop:Function;
      
      private var _name:String;
      
      public var cellId:uint;
      
      public function get customUnicName() : String {
         return this._name;
      }
      
      public function set dropValidator(param1:Function) : void {
         this._dropValidator = param1;
      }
      
      public function get dropValidator() : Function {
         return this._dropValidator;
      }
      
      public function set removeDropSource(param1:Function) : void {
         this._removeDropSource = param1;
      }
      
      public function get removeDropSource() : Function {
         return this._removeDropSource;
      }
      
      public function set processDrop(param1:Function) : void {
         this._processDrop = param1;
      }
      
      public function get processDrop() : Function {
         return this._processDrop;
      }
      
      private function returnTrueFunction(... rest) : Boolean {
         return true;
      }
   }
}
