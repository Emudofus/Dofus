package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PrismFightersInformation extends Object implements INetworkType
   {
      
      public function PrismFightersInformation() {
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.allyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
         super();
      }
      
      public static const protocolId:uint = 443;
      
      public var subAreaId:uint = 0;
      
      public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;
      
      public var allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      public var enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations>;
      
      public function getTypeId() : uint {
         return 443;
      }
      
      public function initPrismFightersInformation(param1:uint=0, param2:ProtectedEntityWaitingForHelpInfo=null, param3:Vector.<CharacterMinimalPlusLookInformations>=null, param4:Vector.<CharacterMinimalPlusLookInformations>=null) : PrismFightersInformation {
         this.subAreaId = param1;
         this.waitingForHelpInfo = param2;
         this.allyCharactersInformations = param3;
         this.enemyCharactersInformations = param4;
         return this;
      }
      
      public function reset() : void {
         this.subAreaId = 0;
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PrismFightersInformation(param1);
      }
      
      public function serializeAs_PrismFightersInformation(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeShort(this.subAreaId);
            this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(param1);
            param1.writeShort(this.allyCharactersInformations.length);
            _loc2_ = 0;
            while(_loc2_ < this.allyCharactersInformations.length)
            {
               param1.writeShort((this.allyCharactersInformations[_loc2_] as CharacterMinimalPlusLookInformations).getTypeId());
               (this.allyCharactersInformations[_loc2_] as CharacterMinimalPlusLookInformations).serialize(param1);
               _loc2_++;
            }
            param1.writeShort(this.enemyCharactersInformations.length);
            _loc3_ = 0;
            while(_loc3_ < this.enemyCharactersInformations.length)
            {
               param1.writeShort((this.enemyCharactersInformations[_loc3_] as CharacterMinimalPlusLookInformations).getTypeId());
               (this.enemyCharactersInformations[_loc3_] as CharacterMinimalPlusLookInformations).serialize(param1);
               _loc3_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismFightersInformation(param1);
      }
      
      public function deserializeAs_PrismFightersInformation(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:CharacterMinimalPlusLookInformations = null;
         var _loc8_:uint = 0;
         var _loc9_:CharacterMinimalPlusLookInformations = null;
         this.subAreaId = param1.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightersInformation.subAreaId.");
         }
         else
         {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserialize(param1);
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = param1.readUnsignedShort();
               _loc7_ = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_loc6_);
               _loc7_.deserialize(param1);
               this.allyCharactersInformations.push(_loc7_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc8_ = param1.readUnsignedShort();
               _loc9_ = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_loc8_);
               _loc9_.deserialize(param1);
               this.enemyCharactersInformations.push(_loc9_);
               _loc5_++;
            }
            return;
         }
      }
   }
}
