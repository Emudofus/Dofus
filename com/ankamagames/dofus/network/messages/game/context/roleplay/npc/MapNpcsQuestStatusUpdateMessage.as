package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.GameRolePlayNpcQuestFlag;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapNpcsQuestStatusUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapNpcsQuestStatusUpdateMessage() {
         this.npcsIdsWithQuest = new Vector.<int>();
         this.questFlags = new Vector.<GameRolePlayNpcQuestFlag>();
         this.npcsIdsWithoutQuest = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 5642;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mapId:int = 0;
      
      public var npcsIdsWithQuest:Vector.<int>;
      
      public var questFlags:Vector.<GameRolePlayNpcQuestFlag>;
      
      public var npcsIdsWithoutQuest:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 5642;
      }
      
      public function initMapNpcsQuestStatusUpdateMessage(mapId:int = 0, npcsIdsWithQuest:Vector.<int> = null, questFlags:Vector.<GameRolePlayNpcQuestFlag> = null, npcsIdsWithoutQuest:Vector.<int> = null) : MapNpcsQuestStatusUpdateMessage {
         this.mapId = mapId;
         this.npcsIdsWithQuest = npcsIdsWithQuest;
         this.questFlags = questFlags;
         this.npcsIdsWithoutQuest = npcsIdsWithoutQuest;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mapId = 0;
         this.npcsIdsWithQuest = new Vector.<int>();
         this.questFlags = new Vector.<GameRolePlayNpcQuestFlag>();
         this.npcsIdsWithoutQuest = new Vector.<int>();
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
         this.serializeAs_MapNpcsQuestStatusUpdateMessage(output);
      }
      
      public function serializeAs_MapNpcsQuestStatusUpdateMessage(output:IDataOutput) : void {
         output.writeInt(this.mapId);
         output.writeShort(this.npcsIdsWithQuest.length);
         var _i2:uint = 0;
         while(_i2 < this.npcsIdsWithQuest.length)
         {
            output.writeInt(this.npcsIdsWithQuest[_i2]);
            _i2++;
         }
         output.writeShort(this.questFlags.length);
         var _i3:uint = 0;
         while(_i3 < this.questFlags.length)
         {
            (this.questFlags[_i3] as GameRolePlayNpcQuestFlag).serializeAs_GameRolePlayNpcQuestFlag(output);
            _i3++;
         }
         output.writeShort(this.npcsIdsWithoutQuest.length);
         var _i4:uint = 0;
         while(_i4 < this.npcsIdsWithoutQuest.length)
         {
            output.writeInt(this.npcsIdsWithoutQuest[_i4]);
            _i4++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapNpcsQuestStatusUpdateMessage(input);
      }
      
      public function deserializeAs_MapNpcsQuestStatusUpdateMessage(input:IDataInput) : void {
         var _val2:* = 0;
         var _item3:GameRolePlayNpcQuestFlag = null;
         var _val4:* = 0;
         this.mapId = input.readInt();
         var _npcsIdsWithQuestLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _npcsIdsWithQuestLen)
         {
            _val2 = input.readInt();
            this.npcsIdsWithQuest.push(_val2);
            _i2++;
         }
         var _questFlagsLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3 < _questFlagsLen)
         {
            _item3 = new GameRolePlayNpcQuestFlag();
            _item3.deserialize(input);
            this.questFlags.push(_item3);
            _i3++;
         }
         var _npcsIdsWithoutQuestLen:uint = input.readUnsignedShort();
         var _i4:uint = 0;
         while(_i4 < _npcsIdsWithoutQuestLen)
         {
            _val4 = input.readInt();
            this.npcsIdsWithoutQuest.push(_val4);
            _i4++;
         }
      }
   }
}
