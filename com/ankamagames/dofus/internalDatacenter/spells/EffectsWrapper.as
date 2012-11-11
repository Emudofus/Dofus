package com.ankamagames.dofus.internalDatacenter.spells
{
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EffectsWrapper extends Object implements IDataCenter
    {
        public var effects:Array;
        public var spellName:String = "";
        public var casterName:String = "";

        public function EffectsWrapper(param1:Array, param2:Spell, param3:String)
        {
            this.effects = param1;
            this.spellName = param2.name;
            this.casterName = param3;
            return;
        }// end function

    }
}
