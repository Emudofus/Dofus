package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterLightInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class MapRunningFightDetailsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapRunningFightDetailsMessage() {
         this.attackers = new Vector.<GameFightFighterLightInformations>();
         this.defenders = new Vector.<GameFightFighterLightInformations>();
         super();
      }
      
      public static const protocolId:uint = 5751;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var attackers:Vector.<GameFightFighterLightInformations>;
      
      public var defenders:Vector.<GameFightFighterLightInformations>;
      
      override public function getMessageId() : uint {
         return 5751;
      }
      
      public function initMapRunningFightDetailsMessage(fightId:uint = 0, attackers:Vector.<GameFightFighterLightInformations> = null, defenders:Vector.<GameFightFighterLightInformations> = null) : MapRunningFightDetailsMessage {
         this.fightId = fightId;
         this.attackers = attackers;
         this.defenders = defenders;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.attackers = new Vector.<GameFightFighterLightInformations>();
         this.defenders = new Vector.<GameFightFighterLightInformations>();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MapRunningFightDetailsMessage(output);
      }
      
      public function serializeAs_MapRunningFightDetailsMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeInt(this.fightId);
            output.writeShort(this.attackers.length);
            _i2 = 0;
            while(_i2 < this.attackers.length)
            {
               output.writeShort((this.attackers[_i2] as GameFightFighterLightInformations).getTypeId());
               (this.attackers[_i2] as GameFightFighterLightInformations).serialize(output);
               _i2++;
            }
            output.writeShort(this.defenders.length);
            _i3 = 0;
            while(_i3 < this.defenders.length)
            {
               output.writeShort((this.defenders[_i3] as GameFightFighterLightInformations).getTypeId());
               (this.defenders[_i3] as GameFightFighterLightInformations).serialize(output);
               _i3++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapRunningFightDetailsMessage(input);
      }
      
      public function deserializeAs_MapRunningFightDetailsMessage(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:GameFightFighterLightInformations = null;
         var _id3:uint = 0;
         var _item3:GameFightFighterLightInformations = null;
         this.fightId = input.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of MapRunningFightDetailsMessage.fightId.");
         }
         else
         {
            _attackersLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _attackersLen)
            {
               _id2 = input.readUnsignedShort();
               _item2 = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_id2);
               _item2.deserialize(input);
               this.attackers.push(_item2);
               _i2++;
            }
            _defendersLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _defendersLen)
            {
               _id3 = input.readUnsignedShort();
               _item3 = ProtocolTypeManager.getInstance(GameFightFighterLightInformations,_id3);
               _item3.deserialize(input);
               this.defenders.push(_item3);
               _i3++;
            }
            return;
         }
      }
   }
}
