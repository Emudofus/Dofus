package com.ankamagames.dofus.network.types.game.character.restriction
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   
   public class ActorRestrictionsInformations extends Object implements INetworkType
   {
      
      public function ActorRestrictionsInformations() {
         super();
      }
      
      public static const protocolId:uint = 204;
      
      public var cantBeAggressed:Boolean = false;
      
      public var cantBeChallenged:Boolean = false;
      
      public var cantTrade:Boolean = false;
      
      public var cantBeAttackedByMutant:Boolean = false;
      
      public var cantRun:Boolean = false;
      
      public var forceSlowWalk:Boolean = false;
      
      public var cantMinimize:Boolean = false;
      
      public var cantMove:Boolean = false;
      
      public var cantAggress:Boolean = false;
      
      public var cantChallenge:Boolean = false;
      
      public var cantExchange:Boolean = false;
      
      public var cantAttack:Boolean = false;
      
      public var cantChat:Boolean = false;
      
      public var cantBeMerchant:Boolean = false;
      
      public var cantUseObject:Boolean = false;
      
      public var cantUseTaxCollector:Boolean = false;
      
      public var cantUseInteractive:Boolean = false;
      
      public var cantSpeakToNPC:Boolean = false;
      
      public var cantChangeZone:Boolean = false;
      
      public var cantAttackMonster:Boolean = false;
      
      public var cantWalk8Directions:Boolean = false;
      
      public function getTypeId() : uint {
         return 204;
      }
      
      public function initActorRestrictionsInformations(param1:Boolean=false, param2:Boolean=false, param3:Boolean=false, param4:Boolean=false, param5:Boolean=false, param6:Boolean=false, param7:Boolean=false, param8:Boolean=false, param9:Boolean=false, param10:Boolean=false, param11:Boolean=false, param12:Boolean=false, param13:Boolean=false, param14:Boolean=false, param15:Boolean=false, param16:Boolean=false, param17:Boolean=false, param18:Boolean=false, param19:Boolean=false, param20:Boolean=false, param21:Boolean=false) : ActorRestrictionsInformations {
         this.cantBeAggressed = param1;
         this.cantBeChallenged = param2;
         this.cantTrade = param3;
         this.cantBeAttackedByMutant = param4;
         this.cantRun = param5;
         this.forceSlowWalk = param6;
         this.cantMinimize = param7;
         this.cantMove = param8;
         this.cantAggress = param9;
         this.cantChallenge = param10;
         this.cantExchange = param11;
         this.cantAttack = param12;
         this.cantChat = param13;
         this.cantBeMerchant = param14;
         this.cantUseObject = param15;
         this.cantUseTaxCollector = param16;
         this.cantUseInteractive = param17;
         this.cantSpeakToNPC = param18;
         this.cantChangeZone = param19;
         this.cantAttackMonster = param20;
         this.cantWalk8Directions = param21;
         return this;
      }
      
      public function reset() : void {
         this.cantBeAggressed = false;
         this.cantBeChallenged = false;
         this.cantTrade = false;
         this.cantBeAttackedByMutant = false;
         this.cantRun = false;
         this.forceSlowWalk = false;
         this.cantMinimize = false;
         this.cantMove = false;
         this.cantAggress = false;
         this.cantChallenge = false;
         this.cantExchange = false;
         this.cantAttack = false;
         this.cantChat = false;
         this.cantBeMerchant = false;
         this.cantUseObject = false;
         this.cantUseTaxCollector = false;
         this.cantUseInteractive = false;
         this.cantSpeakToNPC = false;
         this.cantChangeZone = false;
         this.cantAttackMonster = false;
         this.cantWalk8Directions = false;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ActorRestrictionsInformations(param1);
      }
      
      public function serializeAs_ActorRestrictionsInformations(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.cantBeAggressed);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.cantBeChallenged);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,2,this.cantTrade);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,3,this.cantBeAttackedByMutant);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,4,this.cantRun);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,5,this.forceSlowWalk);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,6,this.cantMinimize);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,7,this.cantMove);
         param1.writeByte(_loc2_);
         var _loc3_:uint = 0;
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,0,this.cantAggress);
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,1,this.cantChallenge);
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,2,this.cantExchange);
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,3,this.cantAttack);
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,4,this.cantChat);
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,5,this.cantBeMerchant);
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,6,this.cantUseObject);
         _loc3_ = BooleanByteWrapper.setFlag(_loc3_,7,this.cantUseTaxCollector);
         param1.writeByte(_loc3_);
         var _loc4_:uint = 0;
         _loc4_ = BooleanByteWrapper.setFlag(_loc4_,0,this.cantUseInteractive);
         _loc4_ = BooleanByteWrapper.setFlag(_loc4_,1,this.cantSpeakToNPC);
         _loc4_ = BooleanByteWrapper.setFlag(_loc4_,2,this.cantChangeZone);
         _loc4_ = BooleanByteWrapper.setFlag(_loc4_,3,this.cantAttackMonster);
         _loc4_ = BooleanByteWrapper.setFlag(_loc4_,4,this.cantWalk8Directions);
         param1.writeByte(_loc4_);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ActorRestrictionsInformations(param1);
      }
      
      public function deserializeAs_ActorRestrictionsInformations(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.cantBeAggressed = BooleanByteWrapper.getFlag(_loc2_,0);
         this.cantBeChallenged = BooleanByteWrapper.getFlag(_loc2_,1);
         this.cantTrade = BooleanByteWrapper.getFlag(_loc2_,2);
         this.cantBeAttackedByMutant = BooleanByteWrapper.getFlag(_loc2_,3);
         this.cantRun = BooleanByteWrapper.getFlag(_loc2_,4);
         this.forceSlowWalk = BooleanByteWrapper.getFlag(_loc2_,5);
         this.cantMinimize = BooleanByteWrapper.getFlag(_loc2_,6);
         this.cantMove = BooleanByteWrapper.getFlag(_loc2_,7);
         var _loc3_:uint = param1.readByte();
         this.cantAggress = BooleanByteWrapper.getFlag(_loc3_,0);
         this.cantChallenge = BooleanByteWrapper.getFlag(_loc3_,1);
         this.cantExchange = BooleanByteWrapper.getFlag(_loc3_,2);
         this.cantAttack = BooleanByteWrapper.getFlag(_loc3_,3);
         this.cantChat = BooleanByteWrapper.getFlag(_loc3_,4);
         this.cantBeMerchant = BooleanByteWrapper.getFlag(_loc3_,5);
         this.cantUseObject = BooleanByteWrapper.getFlag(_loc3_,6);
         this.cantUseTaxCollector = BooleanByteWrapper.getFlag(_loc3_,7);
         var _loc4_:uint = param1.readByte();
         this.cantUseInteractive = BooleanByteWrapper.getFlag(_loc4_,0);
         this.cantSpeakToNPC = BooleanByteWrapper.getFlag(_loc4_,1);
         this.cantChangeZone = BooleanByteWrapper.getFlag(_loc4_,2);
         this.cantAttackMonster = BooleanByteWrapper.getFlag(_loc4_,3);
         this.cantWalk8Directions = BooleanByteWrapper.getFlag(_loc4_,4);
      }
   }
}
