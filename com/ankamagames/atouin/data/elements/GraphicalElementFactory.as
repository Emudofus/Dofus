package com.ankamagames.atouin.data.elements
{
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.BoundingBoxGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.AnimatedGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.EntityGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.ParticlesGraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.BlendedGraphicalElementData;
   import com.ankamagames.jerakine.managers.ErrorManager;
   
   public class GraphicalElementFactory extends Object
   {
      
      public function GraphicalElementFactory() {
         super();
      }
      
      public static function getGraphicalElementData(param1:int, param2:int) : GraphicalElementData {
         switch(param2)
         {
            case GraphicalElementTypes.NORMAL:
               return new NormalGraphicalElementData(param1,param2);
            case GraphicalElementTypes.BOUNDING_BOX:
               return new BoundingBoxGraphicalElementData(param1,param2);
            case GraphicalElementTypes.ANIMATED:
               return new AnimatedGraphicalElementData(param1,param2);
            case GraphicalElementTypes.ENTITY:
               return new EntityGraphicalElementData(param1,param2);
            case GraphicalElementTypes.PARTICLES:
               return new ParticlesGraphicalElementData(param1,param2);
            case GraphicalElementTypes.BLENDED:
               return new BlendedGraphicalElementData(param1,param2);
            default:
               ErrorManager.addError("Unknown graphical element data type " + param2 + " for element " + param1 + "!",false);
               return null;
         }
      }
   }
}
