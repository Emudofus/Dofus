package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class NpcDialogCreationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NpcDialogCreationMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5618;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var mapId:int = 0;
      
      public var npcId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 5618;
      }
      
      public function initNpcDialogCreationMessage(param1:int = 0, param2:int = 0) : NpcDialogCreationMessage
      {
         this.mapId = param1;
         this.npcId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
         this.npcId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_NpcDialogCreationMessage(param1);
      }
      
      public function serializeAs_NpcDialogCreationMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.mapId);
         param1.writeInt(this.npcId);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_NpcDialogCreationMessage(param1);
      }
      
      public function deserializeAs_NpcDialogCreationMessage(param1:ICustomDataInput) : void
      {
         this.mapId = param1.readInt();
         this.npcId = param1.readInt();
      }
   }
}
