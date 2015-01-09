package com.ankamagames.dofus.internalDatacenter.spells
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.datacenter.spells.Spell;

    public class EffectsWrapper implements IDataCenter 
    {

        public var effects:Array;
        public var spellName:String = "";
        public var casterName:String = "";

        public function EffectsWrapper(effect:Array, spell:Spell, name:String)
        {
            this.effects = effect;
            this.spellName = spell.name;
            this.casterName = name;
        }

    }
}//package com.ankamagames.dofus.internalDatacenter.spells

