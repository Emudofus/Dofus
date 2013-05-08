package com.ankamagames.dofus.internalDatacenter.guild
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;


   public class TaxCollectorInFightWrapper extends Object implements IDataCenter
   {
         

      public function TaxCollectorInFightWrapper() {
         super();
      }

      public static function create(pId:int, pAllies:Vector.<CharacterMinimalPlusLookInformations>=null, pEnemies:Vector.<CharacterMinimalPlusLookInformations>=null) : TaxCollectorInFightWrapper {
         var item:TaxCollectorInFightWrapper = null;
         var ally:CharacterMinimalPlusLookInformations = null;
         var enemy:CharacterMinimalPlusLookInformations = null;
         item=new TaxCollectorInFightWrapper();
         item.allyCharactersInformations=new Vector.<TaxCollectorFightersWrapper>();
         item.enemyCharactersInformations=new Vector.<TaxCollectorFightersWrapper>();
         item.uniqueId=pId;
         for each (ally in pAllies)
         {
            item.allyCharactersInformations.push(TaxCollectorFightersWrapper.create(0,ally));
         }
         for each (enemy in pEnemies)
         {
            item.enemyCharactersInformations.push(TaxCollectorFightersWrapper.create(1,enemy));
         }
         return item;
      }

      public var uniqueId:int;

      public var allyCharactersInformations:Vector.<TaxCollectorFightersWrapper>;

      public var enemyCharactersInformations:Vector.<TaxCollectorFightersWrapper>;

      public function update(pId:int, pAllies:Vector.<CharacterMinimalPlusLookInformations>, pEnemies:Vector.<CharacterMinimalPlusLookInformations>) : void {
         var ally:CharacterMinimalPlusLookInformations = null;
         var enemy:CharacterMinimalPlusLookInformations = null;
         this.uniqueId=pId;
         this.allyCharactersInformations=new Vector.<TaxCollectorFightersWrapper>();
         this.enemyCharactersInformations=new Vector.<TaxCollectorFightersWrapper>();
         for each (ally in pAllies)
         {
            this.allyCharactersInformations.push(TaxCollectorFightersWrapper.create(0,ally));
         }
         for each (enemy in pEnemies)
         {
            this.enemyCharactersInformations.push(TaxCollectorFightersWrapper.create(1,enemy));
         }
      }

      public function addPonyFighter(info:TaxCollectorWrapper) : void {
         var tcFighter:CharacterMinimalPlusLookInformations = null;
         if(this.allyCharactersInformations==null)
         {
            this.allyCharactersInformations=new Vector.<TaxCollectorFightersWrapper>();
         }
         if((this.allyCharactersInformations.length==0)||(!this.allyCharactersInformations[0])||(!(this.allyCharactersInformations[0].playerCharactersInformations.entityLook==info.entityLook)))
         {
            tcFighter=new CharacterMinimalPlusLookInformations();
            tcFighter.entityLook=info.entityLook;
            tcFighter.id=info.uniqueId;
            if(Kernel.getWorker().getFrame(SocialFrame)!=null)
            {
               tcFighter.level=(Kernel.getWorker().getFrame(SocialFrame) as SocialFrame).guild.level;
            }
            else
            {
               tcFighter.level=0;
            }
            tcFighter.name=info.lastName+" "+info.firstName;
            this.allyCharactersInformations.splice(0,0,TaxCollectorFightersWrapper.create(0,tcFighter));
         }
      }
   }

}