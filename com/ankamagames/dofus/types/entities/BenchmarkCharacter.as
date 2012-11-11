package com.ankamagames.dofus.types.entities
{
    import com.ankamagames.atouin.entities.behaviours.display.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.types.look.*;

    public class BenchmarkCharacter extends AnimatedCharacter
    {

        public function BenchmarkCharacter(param1:int, param2:TiphonEntityLook)
        {
            super(param1, param2);
            _displayBehavior = AtouinDisplayBehavior.getInstance();
            _movementBehavior = BenchmarkMovementBehavior.getInstance();
            setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE, DirectionsEnum.RIGHT);
            this.id = param1;
            return;
        }// end function

        override public function move(param1:MovementPath, param2:Function = null) : void
        {
            if (!param1.start.equals(position))
            {
                _log.warn("Unsynchronized position for entity " + id + ", jumping from " + position + " to " + param1.start + ".");
                jump(param1.start);
            }
            _movementBehavior = BenchmarkMovementBehavior.getInstance();
            _movementBehavior.move(this, param1, param2);
            return;
        }// end function

    }
}
