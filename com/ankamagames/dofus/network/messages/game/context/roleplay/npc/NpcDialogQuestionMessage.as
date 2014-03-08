package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initNpcDialogQuestionMessage(param1:uint=0, param2:Vector.<String>=null, param3:Vector.<uint>=null) : NpcDialogQuestionMessage {
         this.messageId = param1;
         this.dialogParams = param2;
         this.visibleReplies = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.messageId = 0;
         this.dialogParams = new Vector.<String>();
         this.visibleReplies = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_NpcDialogQuestionMessage(param1);
      }
      
      public function serializeAs_NpcDialogQuestionMessage(param1:IDataOutput) : void {
         if(this.messageId < 0)
         {
            throw new Error("Forbidden value (" + this.messageId + ") on element messageId.");
         }
         else
         {
            param1.writeShort(this.messageId);
            param1.writeShort(this.dialogParams.length);
            _loc2_ = 0;
            while(_loc2_ < this.dialogParams.length)
            {
               param1.writeUTF(this.dialogParams[_loc2_]);
               _loc2_++;
            }
            param1.writeShort(this.visibleReplies.length);
            _loc3_ = 0;
            while(_loc3_ < this.visibleReplies.length)
            {
               if(this.visibleReplies[_loc3_] < 0)
               {
                  throw new Error("Forbidden value (" + this.visibleReplies[_loc3_] + ") on element 3 (starting at 1) of visibleReplies.");
               }
               else
               {
                  param1.writeShort(this.visibleReplies[_loc3_]);
                  _loc3_++;
                  continue;
               }
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_NpcDialogQuestionMessage(param1);
      }
      
      public function deserializeAs_NpcDialogQuestionMessage(param1:IDataInput) : void {
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         this.messageId = param1.readShort();
         if(this.messageId < 0)
         {
            throw new Error("Forbidden value (" + this.messageId + ") on element of NpcDialogQuestionMessage.messageId.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc6_ = param1.readUTF();
               this.dialogParams.push(_loc6_);
               _loc3_++;
            }
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc7_ = param1.readShort();
               if(_loc7_ < 0)
               {
                  throw new Error("Forbidden value (" + _loc7_ + ") on elements of visibleReplies.");
               }
               else
               {
                  this.visibleReplies.push(_loc7_);
                  _loc5_++;
                  continue;
               }
            }
            return;
         }
      }
   }
}
