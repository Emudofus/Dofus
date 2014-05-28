package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   
   public class MountClientData extends Object implements INetworkType
   {
      
      public function MountClientData() {
         this.ancestor = new Vector.<uint>();
         this.behaviors = new Vector.<uint>();
         this.effectList = new Vector.<ObjectEffectInteger>();
         super();
      }
      
      public static const protocolId:uint = 178;
      
      public var id:Number = 0;
      
      public var model:uint = 0;
      
      public var ancestor:Vector.<uint>;
      
      public var behaviors:Vector.<uint>;
      
      public var name:String = "";
      
      public var sex:Boolean = false;
      
      public var ownerId:uint = 0;
      
      public var experience:Number = 0;
      
      public var experienceForLevel:Number = 0;
      
      public var experienceForNextLevel:Number = 0;
      
      public var level:uint = 0;
      
      public var isRideable:Boolean = false;
      
      public var maxPods:uint = 0;
      
      public var isWild:Boolean = false;
      
      public var stamina:uint = 0;
      
      public var staminaMax:uint = 0;
      
      public var maturity:uint = 0;
      
      public var maturityForAdult:uint = 0;
      
      public var energy:uint = 0;
      
      public var energyMax:uint = 0;
      
      public var serenity:int = 0;
      
      public var aggressivityMax:int = 0;
      
      public var serenityMax:uint = 0;
      
      public var love:uint = 0;
      
      public var loveMax:uint = 0;
      
      public var fecondationTime:int = 0;
      
      public var isFecondationReady:Boolean = false;
      
      public var boostLimiter:uint = 0;
      
      public var boostMax:Number = 0;
      
      public var reproductionCount:int = 0;
      
      public var reproductionCountMax:uint = 0;
      
      public var effectList:Vector.<ObjectEffectInteger>;
      
      public function getTypeId() : uint {
         return 178;
      }
      
      public function initMountClientData(id:Number = 0, model:uint = 0, ancestor:Vector.<uint> = null, behaviors:Vector.<uint> = null, name:String = "", sex:Boolean = false, ownerId:uint = 0, experience:Number = 0, experienceForLevel:Number = 0, experienceForNextLevel:Number = 0, level:uint = 0, isRideable:Boolean = false, maxPods:uint = 0, isWild:Boolean = false, stamina:uint = 0, staminaMax:uint = 0, maturity:uint = 0, maturityForAdult:uint = 0, energy:uint = 0, energyMax:uint = 0, serenity:int = 0, aggressivityMax:int = 0, serenityMax:uint = 0, love:uint = 0, loveMax:uint = 0, fecondationTime:int = 0, isFecondationReady:Boolean = false, boostLimiter:uint = 0, boostMax:Number = 0, reproductionCount:int = 0, reproductionCountMax:uint = 0, effectList:Vector.<ObjectEffectInteger> = null) : MountClientData {
         this.id = id;
         this.model = model;
         this.ancestor = ancestor;
         this.behaviors = behaviors;
         this.name = name;
         this.sex = sex;
         this.ownerId = ownerId;
         this.experience = experience;
         this.experienceForLevel = experienceForLevel;
         this.experienceForNextLevel = experienceForNextLevel;
         this.level = level;
         this.isRideable = isRideable;
         this.maxPods = maxPods;
         this.isWild = isWild;
         this.stamina = stamina;
         this.staminaMax = staminaMax;
         this.maturity = maturity;
         this.maturityForAdult = maturityForAdult;
         this.energy = energy;
         this.energyMax = energyMax;
         this.serenity = serenity;
         this.aggressivityMax = aggressivityMax;
         this.serenityMax = serenityMax;
         this.love = love;
         this.loveMax = loveMax;
         this.fecondationTime = fecondationTime;
         this.isFecondationReady = isFecondationReady;
         this.boostLimiter = boostLimiter;
         this.boostMax = boostMax;
         this.reproductionCount = reproductionCount;
         this.reproductionCountMax = reproductionCountMax;
         this.effectList = effectList;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.model = 0;
         this.ancestor = new Vector.<uint>();
         this.behaviors = new Vector.<uint>();
         this.name = "";
         this.sex = false;
         this.ownerId = 0;
         this.experience = 0;
         this.experienceForLevel = 0;
         this.experienceForNextLevel = 0;
         this.level = 0;
         this.isRideable = false;
         this.maxPods = 0;
         this.isWild = false;
         this.stamina = 0;
         this.staminaMax = 0;
         this.maturity = 0;
         this.maturityForAdult = 0;
         this.energy = 0;
         this.energyMax = 0;
         this.serenity = 0;
         this.aggressivityMax = 0;
         this.serenityMax = 0;
         this.love = 0;
         this.loveMax = 0;
         this.fecondationTime = 0;
         this.isFecondationReady = false;
         this.boostLimiter = 0;
         this.boostMax = 0;
         this.reproductionCount = 0;
         this.reproductionCountMax = 0;
         this.effectList = new Vector.<ObjectEffectInteger>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_MountClientData(output);
      }
      
      public function serializeAs_MountClientData(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.sex);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isRideable);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.isWild);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.isFecondationReady);
         output.writeByte(_box0);
         output.writeDouble(this.id);
         if(this.model < 0)
         {
            throw new Error("Forbidden value (" + this.model + ") on element model.");
         }
         else
         {
            output.writeInt(this.model);
            output.writeShort(this.ancestor.length);
            _i3 = 0;
            while(_i3 < this.ancestor.length)
            {
               if(this.ancestor[_i3] < 0)
               {
                  throw new Error("Forbidden value (" + this.ancestor[_i3] + ") on element 3 (starting at 1) of ancestor.");
               }
               else
               {
                  output.writeInt(this.ancestor[_i3]);
                  _i3++;
                  continue;
               }
            }
            output.writeShort(this.behaviors.length);
            _i4 = 0;
            while(_i4 < this.behaviors.length)
            {
               if(this.behaviors[_i4] < 0)
               {
                  throw new Error("Forbidden value (" + this.behaviors[_i4] + ") on element 4 (starting at 1) of behaviors.");
               }
               else
               {
                  output.writeInt(this.behaviors[_i4]);
                  _i4++;
                  continue;
               }
            }
            output.writeUTF(this.name);
            if(this.ownerId < 0)
            {
               throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
            }
            else
            {
               output.writeInt(this.ownerId);
               output.writeDouble(this.experience);
               output.writeDouble(this.experienceForLevel);
               output.writeDouble(this.experienceForNextLevel);
               if(this.level < 0)
               {
                  throw new Error("Forbidden value (" + this.level + ") on element level.");
               }
               else
               {
                  output.writeByte(this.level);
                  if(this.maxPods < 0)
                  {
                     throw new Error("Forbidden value (" + this.maxPods + ") on element maxPods.");
                  }
                  else
                  {
                     output.writeInt(this.maxPods);
                     if(this.stamina < 0)
                     {
                        throw new Error("Forbidden value (" + this.stamina + ") on element stamina.");
                     }
                     else
                     {
                        output.writeInt(this.stamina);
                        if(this.staminaMax < 0)
                        {
                           throw new Error("Forbidden value (" + this.staminaMax + ") on element staminaMax.");
                        }
                        else
                        {
                           output.writeInt(this.staminaMax);
                           if(this.maturity < 0)
                           {
                              throw new Error("Forbidden value (" + this.maturity + ") on element maturity.");
                           }
                           else
                           {
                              output.writeInt(this.maturity);
                              if(this.maturityForAdult < 0)
                              {
                                 throw new Error("Forbidden value (" + this.maturityForAdult + ") on element maturityForAdult.");
                              }
                              else
                              {
                                 output.writeInt(this.maturityForAdult);
                                 if(this.energy < 0)
                                 {
                                    throw new Error("Forbidden value (" + this.energy + ") on element energy.");
                                 }
                                 else
                                 {
                                    output.writeInt(this.energy);
                                    if(this.energyMax < 0)
                                    {
                                       throw new Error("Forbidden value (" + this.energyMax + ") on element energyMax.");
                                    }
                                    else
                                    {
                                       output.writeInt(this.energyMax);
                                       output.writeInt(this.serenity);
                                       output.writeInt(this.aggressivityMax);
                                       if(this.serenityMax < 0)
                                       {
                                          throw new Error("Forbidden value (" + this.serenityMax + ") on element serenityMax.");
                                       }
                                       else
                                       {
                                          output.writeInt(this.serenityMax);
                                          if(this.love < 0)
                                          {
                                             throw new Error("Forbidden value (" + this.love + ") on element love.");
                                          }
                                          else
                                          {
                                             output.writeInt(this.love);
                                             if(this.loveMax < 0)
                                             {
                                                throw new Error("Forbidden value (" + this.loveMax + ") on element loveMax.");
                                             }
                                             else
                                             {
                                                output.writeInt(this.loveMax);
                                                output.writeInt(this.fecondationTime);
                                                if(this.boostLimiter < 0)
                                                {
                                                   throw new Error("Forbidden value (" + this.boostLimiter + ") on element boostLimiter.");
                                                }
                                                else
                                                {
                                                   output.writeInt(this.boostLimiter);
                                                   output.writeDouble(this.boostMax);
                                                   output.writeInt(this.reproductionCount);
                                                   if(this.reproductionCountMax < 0)
                                                   {
                                                      throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element reproductionCountMax.");
                                                   }
                                                   else
                                                   {
                                                      output.writeInt(this.reproductionCountMax);
                                                      output.writeShort(this.effectList.length);
                                                      _i32 = 0;
                                                      while(_i32 < this.effectList.length)
                                                      {
                                                         (this.effectList[_i32] as ObjectEffectInteger).serializeAs_ObjectEffectInteger(output);
                                                         _i32++;
                                                      }
                                                      return;
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MountClientData(input);
      }
      
      public function deserializeAs_MountClientData(input:IDataInput) : void {
         var _val3:uint = 0;
         var _val4:uint = 0;
         var _item32:ObjectEffectInteger = null;
         var _box0:uint = input.readByte();
         this.sex = BooleanByteWrapper.getFlag(_box0,0);
         this.isRideable = BooleanByteWrapper.getFlag(_box0,1);
         this.isWild = BooleanByteWrapper.getFlag(_box0,2);
         this.isFecondationReady = BooleanByteWrapper.getFlag(_box0,3);
         this.id = input.readDouble();
         this.model = input.readInt();
         if(this.model < 0)
         {
            throw new Error("Forbidden value (" + this.model + ") on element of MountClientData.model.");
         }
         else
         {
            _ancestorLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _ancestorLen)
            {
               _val3 = input.readInt();
               if(_val3 < 0)
               {
                  throw new Error("Forbidden value (" + _val3 + ") on elements of ancestor.");
               }
               else
               {
                  this.ancestor.push(_val3);
                  _i3++;
                  continue;
               }
            }
            _behaviorsLen = input.readUnsignedShort();
            _i4 = 0;
            while(_i4 < _behaviorsLen)
            {
               _val4 = input.readInt();
               if(_val4 < 0)
               {
                  throw new Error("Forbidden value (" + _val4 + ") on elements of behaviors.");
               }
               else
               {
                  this.behaviors.push(_val4);
                  _i4++;
                  continue;
               }
            }
            this.name = input.readUTF();
            this.ownerId = input.readInt();
            if(this.ownerId < 0)
            {
               throw new Error("Forbidden value (" + this.ownerId + ") on element of MountClientData.ownerId.");
            }
            else
            {
               this.experience = input.readDouble();
               this.experienceForLevel = input.readDouble();
               this.experienceForNextLevel = input.readDouble();
               this.level = input.readByte();
               if(this.level < 0)
               {
                  throw new Error("Forbidden value (" + this.level + ") on element of MountClientData.level.");
               }
               else
               {
                  this.maxPods = input.readInt();
                  if(this.maxPods < 0)
                  {
                     throw new Error("Forbidden value (" + this.maxPods + ") on element of MountClientData.maxPods.");
                  }
                  else
                  {
                     this.stamina = input.readInt();
                     if(this.stamina < 0)
                     {
                        throw new Error("Forbidden value (" + this.stamina + ") on element of MountClientData.stamina.");
                     }
                     else
                     {
                        this.staminaMax = input.readInt();
                        if(this.staminaMax < 0)
                        {
                           throw new Error("Forbidden value (" + this.staminaMax + ") on element of MountClientData.staminaMax.");
                        }
                        else
                        {
                           this.maturity = input.readInt();
                           if(this.maturity < 0)
                           {
                              throw new Error("Forbidden value (" + this.maturity + ") on element of MountClientData.maturity.");
                           }
                           else
                           {
                              this.maturityForAdult = input.readInt();
                              if(this.maturityForAdult < 0)
                              {
                                 throw new Error("Forbidden value (" + this.maturityForAdult + ") on element of MountClientData.maturityForAdult.");
                              }
                              else
                              {
                                 this.energy = input.readInt();
                                 if(this.energy < 0)
                                 {
                                    throw new Error("Forbidden value (" + this.energy + ") on element of MountClientData.energy.");
                                 }
                                 else
                                 {
                                    this.energyMax = input.readInt();
                                    if(this.energyMax < 0)
                                    {
                                       throw new Error("Forbidden value (" + this.energyMax + ") on element of MountClientData.energyMax.");
                                    }
                                    else
                                    {
                                       this.serenity = input.readInt();
                                       this.aggressivityMax = input.readInt();
                                       this.serenityMax = input.readInt();
                                       if(this.serenityMax < 0)
                                       {
                                          throw new Error("Forbidden value (" + this.serenityMax + ") on element of MountClientData.serenityMax.");
                                       }
                                       else
                                       {
                                          this.love = input.readInt();
                                          if(this.love < 0)
                                          {
                                             throw new Error("Forbidden value (" + this.love + ") on element of MountClientData.love.");
                                          }
                                          else
                                          {
                                             this.loveMax = input.readInt();
                                             if(this.loveMax < 0)
                                             {
                                                throw new Error("Forbidden value (" + this.loveMax + ") on element of MountClientData.loveMax.");
                                             }
                                             else
                                             {
                                                this.fecondationTime = input.readInt();
                                                this.boostLimiter = input.readInt();
                                                if(this.boostLimiter < 0)
                                                {
                                                   throw new Error("Forbidden value (" + this.boostLimiter + ") on element of MountClientData.boostLimiter.");
                                                }
                                                else
                                                {
                                                   this.boostMax = input.readDouble();
                                                   this.reproductionCount = input.readInt();
                                                   this.reproductionCountMax = input.readInt();
                                                   if(this.reproductionCountMax < 0)
                                                   {
                                                      throw new Error("Forbidden value (" + this.reproductionCountMax + ") on element of MountClientData.reproductionCountMax.");
                                                   }
                                                   else
                                                   {
                                                      _effectListLen = input.readUnsignedShort();
                                                      _i32 = 0;
                                                      while(_i32 < _effectListLen)
                                                      {
                                                         _item32 = new ObjectEffectInteger();
                                                         _item32.deserialize(input);
                                                         this.effectList.push(_item32);
                                                         _i32++;
                                                      }
                                                      return;
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
