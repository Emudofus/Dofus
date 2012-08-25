package com.ankamagames.dofus.internalDatacenter.guild
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.network.types.game.character.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class TaxCollectorInFightWrapper extends Object implements IDataCenter
    {
        public var uniqueId:int;
        public var allyCharactersInformations:Vector.<TaxCollectorFightersWrapper>;
        public var enemyCharactersInformations:Vector.<TaxCollectorFightersWrapper>;

        public function TaxCollectorInFightWrapper()
        {
            return;
        }// end function

        public function update(param1:int, param2:Vector.<CharacterMinimalPlusLookInformations>, param3:Vector.<CharacterMinimalPlusLookInformations>) : void
        {
            var _loc_4:CharacterMinimalPlusLookInformations = null;
            var _loc_5:CharacterMinimalPlusLookInformations = null;
            this.uniqueId = param1;
            this.allyCharactersInformations = new Vector.<TaxCollectorFightersWrapper>;
            this.enemyCharactersInformations = new Vector.<TaxCollectorFightersWrapper>;
            for each (_loc_4 in param2)
            {
                
                this.allyCharactersInformations.push(TaxCollectorFightersWrapper.create(0, _loc_4));
            }
            for each (_loc_5 in param3)
            {
                
                this.enemyCharactersInformations.push(TaxCollectorFightersWrapper.create(1, _loc_5));
            }
            return;
        }// end function

        public function addPonyFighter(param1:TaxCollectorWrapper) : void
        {
            var _loc_2:CharacterMinimalPlusLookInformations = null;
            if (this.allyCharactersInformations == null)
            {
                this.allyCharactersInformations = new Vector.<TaxCollectorFightersWrapper>;
            }
            if (this.allyCharactersInformations.length == 0 || !this.allyCharactersInformations[0] || this.allyCharactersInformations[0].playerCharactersInformations.entityLook != param1.entityLook)
            {
                _loc_2 = new CharacterMinimalPlusLookInformations();
                _loc_2.entityLook = param1.entityLook;
                _loc_2.id = param1.uniqueId;
                if (Kernel.getWorker().getFrame(SocialFrame) != null)
                {
                    _loc_2.level = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild.level;
                }
                else
                {
                    _loc_2.level = 0;
                }
                _loc_2.name = param1.lastName + " " + param1.firstName;
                this.allyCharactersInformations.splice(0, 0, TaxCollectorFightersWrapper.create(0, _loc_2));
            }
            return;
        }// end function

        public static function create(param1:int, param2:Vector.<CharacterMinimalPlusLookInformations> = null, param3:Vector.<CharacterMinimalPlusLookInformations> = null) : TaxCollectorInFightWrapper
        {
            var _loc_4:TaxCollectorInFightWrapper = null;
            var _loc_5:CharacterMinimalPlusLookInformations = null;
            var _loc_6:CharacterMinimalPlusLookInformations = null;
            _loc_4 = new TaxCollectorInFightWrapper;
            _loc_4.allyCharactersInformations = new Vector.<TaxCollectorFightersWrapper>;
            _loc_4.enemyCharactersInformations = new Vector.<TaxCollectorFightersWrapper>;
            _loc_4.uniqueId = param1;
            for each (_loc_5 in param2)
            {
                
                _loc_4.allyCharactersInformations.push(TaxCollectorFightersWrapper.create(0, _loc_5));
            }
            for each (_loc_6 in param3)
            {
                
                _loc_4.enemyCharactersInformations.push(TaxCollectorFightersWrapper.create(1, _loc_6));
            }
            return _loc_4;
        }// end function

    }
}
