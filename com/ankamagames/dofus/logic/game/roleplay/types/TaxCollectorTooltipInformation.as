package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.dofus.internalDatacenter.guild.*;

    public class TaxCollectorTooltipInformation extends Object
    {
        public var lastName:String;
        public var firstName:String;
        public var guildIdentity:GuildWrapper;
        public var taxCollectorAttack:int;

        public function TaxCollectorTooltipInformation(param1:String, param2:String, param3:GuildWrapper, param4:int)
        {
            this.lastName = param2;
            this.firstName = param1;
            this.guildIdentity = param3;
            this.taxCollectorAttack = param4;
            return;
        }// end function

    }
}
