package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
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
      
      public function initPrismFightersInformation(subAreaId:uint = 0, waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo = null, allyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null, enemyCharactersInformations:Vector.<CharacterMinimalPlusLookInformations> = null) : PrismFightersInformation {
         this.subAreaId = subAreaId;
         this.waitingForHelpInfo = waitingForHelpInfo;
         this.allyCharactersInformations = allyCharactersInformations;
         this.enemyCharactersInformations = enemyCharactersInformations;
         return this;
      }
      
      public function reset() : void {
         this.subAreaId = 0;
         this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
         this.enemyCharactersInformations = new Vector.<CharacterMinimalPlusLookInformations>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PrismFightersInformation(output);
      }
      
      public function serializeAs_PrismFightersInformation(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
            output.writeShort(this.allyCharactersInformations.length);
            _i3 = 0;
            while(_i3 < this.allyCharactersInformations.length)
            {
               output.writeShort((this.allyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).getTypeId());
               (this.allyCharactersInformations[_i3] as CharacterMinimalPlusLookInformations).serialize(output);
               _i3++;
            }
            output.writeShort(this.enemyCharactersInformations.length);
            _i4 = 0;
            while(_i4 < this.enemyCharactersInformations.length)
            {
               output.writeShort((this.enemyCharactersInformations[_i4] as CharacterMinimalPlusLookInformations).getTypeId());
               (this.enemyCharactersInformations[_i4] as CharacterMinimalPlusLookInformations).serialize(output);
               _i4++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightersInformation(input);
      }
      
      public function deserializeAs_PrismFightersInformation(input:IDataInput) : void {
         var _id3:uint = 0;
         var _item3:CharacterMinimalPlusLookInformations = null;
         var _id4:uint = 0;
         var _item4:CharacterMinimalPlusLookInformations = null;
         this.subAreaId = input.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightersInformation.subAreaId.");
         }
         else
         {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserialize(input);
            _allyCharactersInformationsLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _allyCharactersInformationsLen)
            {
               _id3 = input.readUnsignedShort();
               _item3 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id3);
               _item3.deserialize(input);
               this.allyCharactersInformations.push(_item3);
               _i3++;
            }
            _enemyCharactersInformationsLen = input.readUnsignedShort();
            _i4 = 0;
            while(_i4 < _enemyCharactersInformationsLen)
            {
               _id4 = input.readUnsignedShort();
               _item4 = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id4);
               _item4.deserialize(input);
               this.enemyCharactersInformations.push(_item4);
               _i4++;
            }
            return;
         }
      }
   }
}
