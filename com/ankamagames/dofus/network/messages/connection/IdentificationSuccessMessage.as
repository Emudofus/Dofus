package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class IdentificationSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function IdentificationSuccessMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 22;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var login:String = "";
      
      public var nickname:String = "";
      
      public var accountId:uint = 0;
      
      public var communityId:uint = 0;
      
      public var hasRights:Boolean = false;
      
      public var secretQuestion:String = "";
      
      public var accountCreation:Number = 0;
      
      public var subscriptionElapsedDuration:Number = 0;
      
      public var subscriptionEndDate:Number = 0;
      
      public var wasAlreadyConnected:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 22;
      }
      
      public function initIdentificationSuccessMessage(param1:String = "", param2:String = "", param3:uint = 0, param4:uint = 0, param5:Boolean = false, param6:String = "", param7:Number = 0, param8:Number = 0, param9:Number = 0, param10:Boolean = false) : IdentificationSuccessMessage
      {
         this.login = param1;
         this.nickname = param2;
         this.accountId = param3;
         this.communityId = param4;
         this.hasRights = param5;
         this.secretQuestion = param6;
         this.accountCreation = param7;
         this.subscriptionElapsedDuration = param8;
         this.subscriptionEndDate = param9;
         this.wasAlreadyConnected = param10;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.login = "";
         this.nickname = "";
         this.accountId = 0;
         this.communityId = 0;
         this.hasRights = false;
         this.secretQuestion = "";
         this.accountCreation = 0;
         this.subscriptionElapsedDuration = 0;
         this.subscriptionEndDate = 0;
         this.wasAlreadyConnected = false;
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
         this.serializeAs_IdentificationSuccessMessage(param1);
      }
      
      public function serializeAs_IdentificationSuccessMessage(param1:ICustomDataOutput) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.hasRights);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.wasAlreadyConnected);
         param1.writeByte(_loc2_);
         param1.writeUTF(this.login);
         param1.writeUTF(this.nickname);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         else
         {
            param1.writeInt(this.accountId);
            if(this.communityId < 0)
            {
               throw new Error("Forbidden value (" + this.communityId + ") on element communityId.");
            }
            else
            {
               param1.writeByte(this.communityId);
               param1.writeUTF(this.secretQuestion);
               if(this.accountCreation < 0 || this.accountCreation > 9.007199254740992E15)
               {
                  throw new Error("Forbidden value (" + this.accountCreation + ") on element accountCreation.");
               }
               else
               {
                  param1.writeDouble(this.accountCreation);
                  if(this.subscriptionElapsedDuration < 0 || this.subscriptionElapsedDuration > 9.007199254740992E15)
                  {
                     throw new Error("Forbidden value (" + this.subscriptionElapsedDuration + ") on element subscriptionElapsedDuration.");
                  }
                  else
                  {
                     param1.writeDouble(this.subscriptionElapsedDuration);
                     if(this.subscriptionEndDate < 0 || this.subscriptionEndDate > 9.007199254740992E15)
                     {
                        throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element subscriptionEndDate.");
                     }
                     else
                     {
                        param1.writeDouble(this.subscriptionEndDate);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_IdentificationSuccessMessage(param1);
      }
      
      public function deserializeAs_IdentificationSuccessMessage(param1:ICustomDataInput) : void
      {
         var _loc2_:uint = param1.readByte();
         this.hasRights = BooleanByteWrapper.getFlag(_loc2_,0);
         this.wasAlreadyConnected = BooleanByteWrapper.getFlag(_loc2_,1);
         this.login = param1.readUTF();
         this.nickname = param1.readUTF();
         this.accountId = param1.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of IdentificationSuccessMessage.accountId.");
         }
         else
         {
            this.communityId = param1.readByte();
            if(this.communityId < 0)
            {
               throw new Error("Forbidden value (" + this.communityId + ") on element of IdentificationSuccessMessage.communityId.");
            }
            else
            {
               this.secretQuestion = param1.readUTF();
               this.accountCreation = param1.readDouble();
               if(this.accountCreation < 0 || this.accountCreation > 9.007199254740992E15)
               {
                  throw new Error("Forbidden value (" + this.accountCreation + ") on element of IdentificationSuccessMessage.accountCreation.");
               }
               else
               {
                  this.subscriptionElapsedDuration = param1.readDouble();
                  if(this.subscriptionElapsedDuration < 0 || this.subscriptionElapsedDuration > 9.007199254740992E15)
                  {
                     throw new Error("Forbidden value (" + this.subscriptionElapsedDuration + ") on element of IdentificationSuccessMessage.subscriptionElapsedDuration.");
                  }
                  else
                  {
                     this.subscriptionEndDate = param1.readDouble();
                     if(this.subscriptionEndDate < 0 || this.subscriptionEndDate > 9.007199254740992E15)
                     {
                        throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element of IdentificationSuccessMessage.subscriptionEndDate.");
                     }
                     else
                     {
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
