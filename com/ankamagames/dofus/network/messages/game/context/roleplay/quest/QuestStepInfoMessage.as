package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class QuestStepInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestStepInfoMessage() {
         this.infos = new QuestActiveInformations();
         super();
      }
      
      public static const protocolId:uint = 5625;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var infos:QuestActiveInformations;
      
      override public function getMessageId() : uint {
         return 5625;
      }
      
      public function initQuestStepInfoMessage(infos:QuestActiveInformations=null) : QuestStepInfoMessage {
         this.infos = infos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.infos = new QuestActiveInformations();
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
         this.serializeAs_QuestStepInfoMessage(output);
      }
      
      public function serializeAs_QuestStepInfoMessage(output:IDataOutput) : void {
         output.writeShort(this.infos.getTypeId());
         this.infos.serialize(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_QuestStepInfoMessage(input);
      }
      
      public function deserializeAs_QuestStepInfoMessage(input:IDataInput) : void {
         var _id1:uint = input.readUnsignedShort();
         this.infos = ProtocolTypeManager.getInstance(QuestActiveInformations,_id1);
         this.infos.deserialize(input);
      }
   }
}
