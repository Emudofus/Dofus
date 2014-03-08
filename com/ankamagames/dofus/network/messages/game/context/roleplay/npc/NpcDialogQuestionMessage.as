package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class NpcDialogQuestionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function NpcDialogQuestionMessage() {
         this.dialogParams = new Vector.<String>();
         this.visibleReplies = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5617;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var messageId:uint = 0;
      
      public var dialogParams:Vector.<String>;
      
      public var visibleReplies:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 5617;
      }
      
      public function initNpcDialogQuestionMessage(messageId:uint=0, dialogParams:Vector.<String>=null, visibleReplies:Vector.<uint>=null) : NpcDialogQuestionMessage {
         this.messageId = messageId;
         this.dialogParams = dialogParams;
         this.visibleReplies = visibleReplies;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.messageId = 0;
         this.dialogParams = new Vector.<String>();
         this.visibleReplies = new Vector.<uint>();
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
         this.serializeAs_NpcDialogQuestionMessage(output);
      }
      
      public function serializeAs_NpcDialogQuestionMessage(output:IDataOutput) : void {
         if(this.messageId < 0)
         {
            throw new Error("Forbidden value (" + this.messageId + ") on element messageId.");
         }
         else
         {
            output.writeShort(this.messageId);
            output.writeShort(this.dialogParams.length);
            _i2 = 0;
            while(_i2 < this.dialogParams.length)
            {
               output.writeUTF(this.dialogParams[_i2]);
               _i2++;
            }
            output.writeShort(this.visibleReplies.length);
            _i3 = 0;
            while(_i3 < this.visibleReplies.length)
            {
               if(this.visibleReplies[_i3] < 0)
               {
                  throw new Error("Forbidden value (" + this.visibleReplies[_i3] + ") on element 3 (starting at 1) of visibleReplies.");
               }
               else
               {
                  output.writeShort(this.visibleReplies[_i3]);
                  _i3++;
                  continue;
               }
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_NpcDialogQuestionMessage(input);
      }
      
      public function deserializeAs_NpcDialogQuestionMessage(input:IDataInput) : void {
         var _val2:String = null;
         var _val3:uint = 0;
         this.messageId = input.readShort();
         if(this.messageId < 0)
         {
            throw new Error("Forbidden value (" + this.messageId + ") on element of NpcDialogQuestionMessage.messageId.");
         }
         else
         {
            _dialogParamsLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _dialogParamsLen)
            {
               _val2 = input.readUTF();
               this.dialogParams.push(_val2);
               _i2++;
            }
            _visibleRepliesLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _visibleRepliesLen)
            {
               _val3 = input.readShort();
               if(_val3 < 0)
               {
                  throw new Error("Forbidden value (" + _val3 + ") on elements of visibleReplies.");
               }
               else
               {
                  this.visibleReplies.push(_val3);
                  _i3++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
