package com.ankamagames.atouin.data.map.elements
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.IDataInput;
   
   public class BasicElement extends Object
   {
      
      public function BasicElement(cell:Cell) {
         super();
         this._cell = cell;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BasicElement));
      
      public static function getElementFromType(type:int, cell:Cell) : BasicElement {
         switch(type)
         {
            case ElementTypesEnum.GRAPHICAL:
               return new GraphicalElement(cell);
            case ElementTypesEnum.SOUND:
               return new SoundElement(cell);
         }
      }
      
      private var _cell:Cell;
      
      public function get cell() : Cell {
         return this._cell;
      }
      
      public function get elementType() : int {
         return -1;
      }
      
      public function fromRaw(raw:IDataInput, mapVersion:int) : void {
         throw new Error("Cette méthode doit être surchargée !");
      }
   }
}
