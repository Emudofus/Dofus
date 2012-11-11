package com.ankamagames.atouin.data.elements
{
    import com.ankamagames.atouin.data.elements.subtypes.*;

    public class GraphicalElementFactory extends Object
    {

        public function GraphicalElementFactory()
        {
            return;
        }// end function

        public static function getGraphicalElementData(param1:int, param2:int) : GraphicalElementData
        {
            switch(param2)
            {
                case GraphicalElementTypes.NORMAL:
                {
                    return new NormalGraphicalElementData(param1, param2);
                }
                case GraphicalElementTypes.BOUNDING_BOX:
                {
                    return new BoundingBoxGraphicalElementData(param1, param2);
                }
                case GraphicalElementTypes.ANIMATED:
                {
                    return new AnimatedGraphicalElementData(param1, param2);
                }
                case GraphicalElementTypes.ENTITY:
                {
                    return new EntityGraphicalElementData(param1, param2);
                }
                case GraphicalElementTypes.PARTICLES:
                {
                    return new ParticlesGraphicalElementData(param1, param2);
                }
                case GraphicalElementTypes.BLENDED:
                {
                    return new BlendedGraphicalElementData(param1, param2);
                }
                default:
                {
                    break;
                }
            }
            throw new ArgumentError("Unknown graphical element data type " + param2 + " for element " + param1 + "!");
        }// end function

    }
}
