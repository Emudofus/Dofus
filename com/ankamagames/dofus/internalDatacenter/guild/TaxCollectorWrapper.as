package com.ankamagames.dofus.internalDatacenter.guild
{
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.network.types.game.guild.tax.*;
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.interfaces.*;
    import flash.utils.*;

    public class TaxCollectorWrapper extends Object implements IDataCenter
    {
        public var uniqueId:int;
        public var firstName:String;
        public var lastName:String;
        public var entityLook:EntityLook;
        public var additionalInformation:AdditionalTaxCollectorInformations;
        public var mapWorldX:int;
        public var mapWorldY:int;
        public var subareaId:int;
        public var state:int;
        public var fightTime:Number;
        public var waitTimeForPlacement:Number;
        public var nbPositionPerTeam:uint;
        public var kamas:int;
        public var experience:int;
        public var pods:int;
        public var itemsValue:int;

        public function TaxCollectorWrapper()
        {
            return;
        }// end function

        public function update(param1:TaxCollectorInformations, param2:TaxCollectorFightersInformation = null) : void
        {
            this.uniqueId = param1.uniqueId;
            this.lastName = TaxCollectorName.getTaxCollectorNameById(param1.lastNameId).name;
            this.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(param1.firtNameId).firstname;
            this.additionalInformation = param1.additionalInfos;
            this.mapWorldX = param1.worldX;
            this.mapWorldY = param1.worldY;
            this.subareaId = param1.subAreaId;
            this.state = param1.state;
            this.entityLook = param1.look;
            this.kamas = param1.kamas;
            this.experience = param1.experience;
            this.pods = param1.pods;
            this.itemsValue = param1.itemsValue;
            if (param1.state == 1)
            {
                this.fightTime = (param1 as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
                this.waitTimeForPlacement = (param1 as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.waitTimeForPlacement * 100;
                this.nbPositionPerTeam = (param1 as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.nbPositionForDefensors;
            }
            else
            {
                this.fightTime = 0;
                this.waitTimeForPlacement = 0;
                this.nbPositionPerTeam = 7;
            }
            return;
        }// end function

        public static function create(param1:TaxCollectorInformations, param2:TaxCollectorFightersInformation = null) : TaxCollectorWrapper
        {
            var _loc_3:* = null;
            _loc_3 = new TaxCollectorWrapper;
            _loc_3.uniqueId = param1.uniqueId;
            _loc_3.lastName = TaxCollectorName.getTaxCollectorNameById(param1.lastNameId).name;
            _loc_3.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(param1.firtNameId).firstname;
            _loc_3.additionalInformation = param1.additionalInfos;
            _loc_3.mapWorldX = param1.worldX;
            _loc_3.mapWorldY = param1.worldY;
            _loc_3.subareaId = param1.subAreaId;
            _loc_3.state = param1.state;
            _loc_3.entityLook = param1.look;
            _loc_3.kamas = param1.kamas;
            _loc_3.experience = param1.experience;
            _loc_3.pods = param1.pods;
            _loc_3.itemsValue = param1.itemsValue;
            if (param1.state == 1)
            {
                _loc_3.fightTime = (param1 as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
                _loc_3.waitTimeForPlacement = (param1 as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.waitTimeForPlacement * 100;
                _loc_3.nbPositionPerTeam = (param1 as TaxCollectorInformationsInWaitForHelpState).waitingForHelpInfo.nbPositionForDefensors;
            }
            else
            {
                _loc_3.fightTime = 0;
                _loc_3.waitTimeForPlacement = 0;
                _loc_3.nbPositionPerTeam = 7;
            }
            return _loc_3;
        }// end function

    }
}
