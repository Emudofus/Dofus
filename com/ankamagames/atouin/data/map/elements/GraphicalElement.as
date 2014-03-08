package com.ankamagames.atouin.data.map.elements
{
   import com.ankamagames.jerakine.types.ColorMultiplicator;
   import flash.geom.Point;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import flash.utils.IDataInput;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.Cell;
   
   public class GraphicalElement extends BasicElement
   {
      
      public function GraphicalElement(cell:Cell) {
         super(cell);
      }
      
      public var elementId:int;
      
      public var hue:ColorMultiplicator;
      
      public var shadow:ColorMultiplicator;
      
      public var finalTeint:ColorMultiplicator;
      
      public var offset:Point;
      
      public var pixelOffset:Point;
      
      public var altitude:int;
      
      public var identifier:uint;
      
      override public function get elementType() : int {
         return ElementTypesEnum.GRAPHICAL;
      }
      
      public function get colorMultiplicator() : ColorMultiplicator {
         return this.finalTeint;
      }
      
      private function calculateFinalTeint() : void {
         var r:Number = this.hue.red + this.shadow.red;
         var g:Number = this.hue.green + this.shadow.green;
         var b:Number = this.hue.blue + this.shadow.blue;
         r = ColorMultiplicator.clamp((r + 128) * 2,0,512);
         g = ColorMultiplicator.clamp((g + 128) * 2,0,512);
         b = ColorMultiplicator.clamp((b + 128) * 2,0,512);
         this.finalTeint = new ColorMultiplicator(r,g,b,true);
      }
      
      override public function fromRaw(raw:IDataInput, mapVersion:int) : void {
         try
         {
            this.elementId = raw.readUnsignedInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("      (GraphicalElement) Element id : " + this.elementId);
            }
            this.hue = new ColorMultiplicator(raw.readByte(),raw.readByte(),raw.readByte());
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("      (GraphicalElement) Hue : " + this.hue);
            }
            this.shadow = new ColorMultiplicator(raw.readByte(),raw.readByte(),raw.readByte());
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("      (GraphicalElement) Shadow : " + this.shadow);
            }
            this.offset = new Point();
            this.pixelOffset = new Point();
            if(mapVersion <= 4)
            {
               this.offset.x = raw.readByte();
               this.offset.y = raw.readByte();
               this.pixelOffset.x = this.offset.x * AtouinConstants.CELL_HALF_WIDTH;
               this.pixelOffset.y = this.offset.y * AtouinConstants.CELL_HALF_HEIGHT;
            }
            else
            {
               this.pixelOffset.x = raw.readShort();
               this.pixelOffset.y = raw.readShort();
               this.offset.x = this.pixelOffset.x / AtouinConstants.CELL_HALF_WIDTH;
               this.offset.y = this.pixelOffset.y / AtouinConstants.CELL_HALF_HEIGHT;
            }
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("      (GraphicalElement) Offset : (" + this.offset.x + ";" + this.offset.y + ")");
            }
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("      (GraphicalElement) Pixel Offset : (" + this.pixelOffset.x + ";" + this.pixelOffset.y + ")");
            }
            this.altitude = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("      (GraphicalElement) Altitude : " + this.altitude);
            }
            this.identifier = raw.readUnsignedInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("      (GraphicalElement) Identifier : " + this.identifier);
            }
            this.calculateFinalTeint();
         }
         catch(e:*)
         {
            throw e;
         }
      }
   }
}
