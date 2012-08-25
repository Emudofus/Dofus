package 
{
    import com.ankamagames.dofus.types.characteristicContextual.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import flash.utils.*;

    class TweenData extends Object
    {
        public var entity:IEntity;
        public var context:CharacteristicContextual;
        public var _tweeningTotalDistance:uint = 40;
        public var _tweeningCurrentDistance:Number = 0;
        public var alpha:Number = 0;
        public var startTime:int;

        function TweenData(param1:CharacteristicContextual, param2:IEntity)
        {
            this.startTime = getTimer();
            this.context = param1;
            this.entity = param2;
            return;
        }// end function

    }
}
