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
      
      public static function create(pType:int, pId:int, pAllies:Array = null, pEnemies:Array = null, fightTime:int = 2147483647, waitTimeForPlacement:Number = 0, nbPositionPerTeam:uint = 5) : SocialEntityInFightWrapper {
         var item:SocialEntityInFightWrapper = null;
         var ally:CharacterMinimalPlusLookInformations = null;
         var enemy:CharacterMinimalPlusLookInformations = null;
         item = new SocialEntityInFightWrapper();
         item.allyCharactersInformations = new Array();
         item.enemyCharactersInformations = new Array();
         item.typeId = pType;
         item.uniqueId = pId;
         item.fightTime = fightTime;
         item.waitTimeForPlacement = waitTimeForPlacement;
         item.nbPositionPerTeam = nbPositionPerTeam;
         for each(ally in pAllies)
         {
            item.allyCharactersInformations.push(SocialFightersWrapper.create(0,ally));
         }
         for each(enemy in pEnemies)
         {
            item.enemyCharactersInformations.push(SocialFightersWrapper.create(1,enemy));
         }
         return item;
      }
      
      public var uniqueId:int;
      
      public var typeId:int;
      
      public var fightTime:int;
      
      public var allyCharactersInformations:Array;
      
      public var enemyCharactersInformations:Array;
      
      public var waitTimeForPlacement:Number;
      
      public var nbPositionPerTeam:uint;
      
      public function update(pType:int, pId:int, pAllies:Array, pEnemies:Array, pFightTime:int = 2147483647, pWaitTimeForPlacement:Number = 0, pNbPositionPerTeam:uint = 5) : void {
         var ally:CharacterMinimalPlusLookInformations = null;
         var enemy:CharacterMinimalPlusLookInformations = null;
         this.typeId = pType;
         this.uniqueId = pId;
         this.fightTime = pFightTime;
         this.waitTimeForPlacement = pWaitTimeForPlacement;
         this.nbPositionPerTeam = pNbPositionPerTeam;
         this.allyCharactersInformations = new Array();
         this.enemyCharactersInformations = new Array();
         for each(ally in pAllies)
         {
            this.allyCharactersInformations.push(SocialFightersWrapper.create(0,ally));
         }
         for each(enemy in pEnemies)
         {
            this.enemyCharactersInformations.push(SocialFightersWrapper.create(1,enemy));
         }
      }
      
      public function addPonyFighter(info:TaxCollectorWrapper) : void {
         var tcFighter:CharacterMinimalPlusLookInformations = null;
         if(this.allyCharactersInformations == null)
         {
            this.allyCharactersInformations = new Array();
         }
         if((this.allyCharactersInformations.length == 0) || (!this.allyCharactersInformations[0]) || (!(this.allyCharactersInformations[0].playerCharactersInformations.entityLook == info.entityLook)))
         {
            tcFighter = new CharacterMinimalPlusLookInformations();
            tcFighter.entityLook = info.entityLook;
            tcFighter.id = info.uniqueId;
            if(Kernel.getWorker().getFrame(SocialFrame) != null)
            {
               tcFighter.level = (Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild.level;
            }
            else
            {
               tcFighter.level = 0;
            }
            tcFighter.name = info.lastName + " " + info.firstName;
            this.allyCharactersInformations.splice(0,0,SocialFightersWrapper.create(0,tcFighter));
         }
      }
   }
}
