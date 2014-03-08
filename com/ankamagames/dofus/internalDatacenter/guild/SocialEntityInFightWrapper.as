package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   
   public class SocialEntityInFightWrapper extends Object implements IDataCenter
   {
      
      public function SocialEntityInFightWrapper() {
         super();
      }
      
      private static const TYPE_TAX_COLLECTOR:int = 0;
      
      private static const TYPE_PRISM:int = 1;
      
      public static function create(param1:int, param2:int, param3:Array=null, param4:Array=null, param5:int=2147483647, param6:Number=0, param7:uint=5) : SocialEntityInFightWrapper {
         var _loc8_:SocialEntityInFightWrapper = null;
         var _loc9_:CharacterMinimalPlusLookInformations = null;
         var _loc10_:CharacterMinimalPlusLookInformations = null;
         _loc8_ = new SocialEntityInFightWrapper();
         _loc8_.allyCharactersInformations = new Array();
         _loc8_.enemyCharactersInformations = new Array();
         _loc8_.typeId = param1;
         _loc8_.uniqueId = param2;
         _loc8_.fightTime = param5;
         _loc8_.waitTimeForPlacement = param6;
         _loc8_.nbPositionPerTeam = param7;
         for each (_loc9_ in param3)
         {
            _loc8_.allyCharactersInformations.push(SocialFightersWrapper.create(0,_loc9_));
         }
         for each (_loc10_ in param4)
         {
            _loc8_.enemyCharactersInformations.push(SocialFightersWrapper.create(1,_loc10_));
         }
         return _loc8_;
      }
      
      public var uniqueId:int;
      
      public var typeId:int;
      
      public var fightTime:int;
      
      public var allyCharactersInformations:Array;
      
      public var enemyCharactersInformations:Array;
      
      public var waitTimeForPlacement:Number;
      
      public var nbPositionPerTeam:uint;
      
      public function update(param1:int, param2:int, param3:Array, param4:Array, param5:int=2147483647, param6:Number=0, param7:uint=5) : void {
         var _loc8_:CharacterMinimalPlusLookInformations = null;
         var _loc9_:CharacterMinimalPlusLookInformations = null;
         this.typeId = param1;
         this.uniqueId = param2;
         this.fightTime = param5;
         this.waitTimeForPlacement = param6;
         this.nbPositionPerTeam = param7;
         this.allyCharactersInformations = new Array();
         this.enemyCharactersInformations = new Array();
         for each (_loc8_ in param3)
         {
            this.allyCharactersInformations.push(SocialFightersWrapper.create(0,_loc8_));
         }
         for each (_loc9_ in param4)
         {
            this.enemyCharactersInformations.push(SocialFightersWrapper.create(1,_loc9_));
         }
      }
      
      public function addPonyFighter(param1:TaxCollectorWrapper) : void {
         var _loc2_:CharacterMinimalPlusLookInformations = null;
         if(this.allyCharactersInformations == null)
         {
            this.allyCharactersInformations = new Array();
         }
         if(this.allyCharactersInformations.length == 0 || !this.allyCharactersInformations[0] || !(this.allyCharactersInformations[0].playerCharactersInformations.entityLook == param1.entityLook))
         {
            _loc2_ = new CharacterMinimalPlusLookInformations();
            _loc2_.entityLook = param1.entityLook;
            _loc2_.id = param1.uniqueId;
            if(Kernel.getWorker().getFrame(SocialFrame) != null)
            {
               _loc2_.level = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild.level;
            }
            else
            {
               _loc2_.level = 0;
            }
            _loc2_.name = param1.lastName + " " + param1.firstName;
            this.allyCharactersInformations.splice(0,0,SocialFightersWrapper.create(0,_loc2_));
         }
      }
   }
}
