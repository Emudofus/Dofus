package com.ankamagames.atouin.data.map.elements
{
    import com.ankamagames.atouin.data.map.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class BasicElement extends Object
    {
        private var _cell:Cell;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(BasicElement));

        public function BasicElement(param1:Cell)
        {
            this._cell = param1;
            return;
        }// end function

        public function get cell() : Cell
        {
            return this._cell;
        }// end function

        public function get elementType() : int
        {
            return -1;
        }// end function

        public function fromRaw(param1:IDataInput, param2:int) : void
        {
            throw new Error("Cette méthode doit être surchargée !");
        }// end function

        public static function getElementFromType(param1:int, param2:Cell) : BasicElement
        {
            switch(param1)
            {
                case ElementTypesEnum.GRAPHICAL:
                {
                    return new GraphicalElement(param2);
                }
                case ElementTypesEnum.SOUND:
                {
                    return new SoundElement(param2);
                }
                default:
                {
                    break;
                }
            }
            throw new UnknownElementError("Un élément de type inconnu " + param1 + " a été trouvé sur la cellule " + param2.cellId + "!");
        }// end function

    }
}
