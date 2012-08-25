package 
{
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.jerakine.interfaces.*;

    class DisplayedEntity extends Object
    {
        public var entityId:int;
        public var text:Label;
        public var target:IRectangle;

        function DisplayedEntity(param1:int = 0, param2:Label = null, param3:IRectangle = null) : void
        {
            this.entityId = param1;
            this.text = param2;
            this.target = param3;
            return;
        }// end function

        public function clear() : void
        {
            this.text.remove();
            this.text = null;
            this.target = null;
            return;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            this.text.visible = param1;
            return;
        }// end function

    }
}
