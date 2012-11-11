package com.ankamagames.dofus.logic.game.fight.types
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.spells.*;

    public class MarkInstance extends Object
    {
        public var markId:int;
        public var markType:int;
        public var associatedSpell:Spell;
        public var selections:Vector.<Selection>;
        public var cells:Vector.<uint>;

        public function MarkInstance()
        {
            return;
        }// end function

    }
}
