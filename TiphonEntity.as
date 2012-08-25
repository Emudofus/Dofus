package 
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.types.look.*;

    class TiphonEntity extends TiphonSprite implements IEntity
    {
        private var _id:uint;

        function TiphonEntity(param1:uint, param2:TiphonEntityLook)
        {
            super(param2);
            this._id = param1;
            mouseEnabled = false;
            mouseChildren = false;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get position() : MapPoint
        {
            return null;
        }// end function

        public function set position(param1:MapPoint) : void
        {
            return;
        }// end function

    }
}
