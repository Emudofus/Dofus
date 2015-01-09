package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.PlayedCharacterApi;
    import d2api.UtilApi;
    import d2api.SoundApi;
    import d2api.SocialApi;
    import d2api.TimeApi;
    import d2components.GraphicContainer;
    import d2components.ScrollContainer;
    import d2components.EntityDisplayer;
    import d2components.Texture;
    import d2components.ButtonContainer;
    import d2components.Label;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2hooks.LeaveDialog;
    import d2hooks.NpcDialogQuestion;
    import d2hooks.TaxCollectorDialogQuestionExtended;
    import d2hooks.AllianceTaxCollectorDialogQuestionExtended;
    import d2hooks.TaxCollectorDialogQuestionBasic;
    import d2hooks.AlliancePrismDialogQuestion;
    import d2hooks.PortalDialogQuestion;
    import d2actions.LeaveDialogRequest;
    import d2actions.NpcDialogReply;
    import d2network.BasicNamedAllianceInformations;
    import d2data.PrismSubAreaWrapper;
    import d2data.AllianceWrapper;
    import d2hooks.*;
    import d2actions.*;

    public class NpcDialog 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var playerApi:PlayedCharacterApi;
        public var utilApi:UtilApi;
        public var soundApi:SoundApi;
        public var socialApi:SocialApi;
        public var timeApi:TimeApi;
        private var _npc:Object;
        private var _replies:Object;
        private var _moreReplies:Object;
        private var _nIndexRep:uint = 0;
        private var _currentMsg:uint;
        private var _labelsWidth:uint = 250;
        private var _aLblReplies:Array;
        private var _aReplies:Array;
        private var _aRepliesIdFromBtn:Array;
        private var _lockAndWaitAnswers:Boolean = false;
        private var _comeBackNeeded:Boolean = false;
        private var _continueNeeded:Boolean = false;
        private var _textParams:Array;
        private var _colorOver:Number;
        private var _currentSelectedAnswer:int = -1;
        private var _lastAnswerIndex:int = -1;
        private var _contentHeight:int;
        public var mainNpcCtr:GraphicContainer;
        public var repliesContainer:GraphicContainer;
        public var ctr_content:ScrollContainer;
        public var entityDisplayer_npc:EntityDisplayer;
        public var tx_background:Texture;
        public var btn_close:ButtonContainer;
        public var lbl_title:Label;
        public var lbl_message:Label;
        public var lbl_hidden:Label;
        public var btn_rep0:ButtonContainer;
        public var btn_rep1:ButtonContainer;
        public var btn_rep2:ButtonContainer;
        public var btn_rep3:ButtonContainer;
        public var btn_rep4:ButtonContainer;
        public var lbl_rep0:Label;
        public var lbl_rep1:Label;
        public var lbl_rep2:Label;
        public var lbl_rep3:Label;
        public var lbl_rep4:Label;
        public var tx_over0:Texture;
        public var tx_over1:Texture;
        public var tx_over2:Texture;
        public var tx_over3:Texture;
        public var tx_over4:Texture;


        public function main(params:Object=null):void
        {
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.sysApi.addHook(LeaveDialog, this.onLeaveDialog);
            this.sysApi.addHook(NpcDialogQuestion, this.onNpcDialogQuestion);
            this.sysApi.addHook(TaxCollectorDialogQuestionExtended, this.onTaxCollectorDialogQuestionExtended);
            this.sysApi.addHook(AllianceTaxCollectorDialogQuestionExtended, this.onAllianceTaxCollectorDialogQuestionExtended);
            this.sysApi.addHook(TaxCollectorDialogQuestionBasic, this.onTaxCollectorDialogQuestionBasic);
            this.sysApi.addHook(AlliancePrismDialogQuestion, this.onAlliancePrismDialogQuestion);
            this.sysApi.addHook(PortalDialogQuestion, this.onPortalDialogQuestion);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("upArrow", this.onShortcut);
            this.uiApi.addShortcutHook("downArrow", this.onShortcut);
            this.uiApi.addComponentHook(this.btn_rep0, "onRollOver");
            this.uiApi.addComponentHook(this.btn_rep0, "onRollOut");
            this.uiApi.addComponentHook(this.btn_rep1, "onRollOver");
            this.uiApi.addComponentHook(this.btn_rep1, "onRollOut");
            this.uiApi.addComponentHook(this.btn_rep2, "onRollOver");
            this.uiApi.addComponentHook(this.btn_rep2, "onRollOut");
            this.uiApi.addComponentHook(this.btn_rep3, "onRollOver");
            this.uiApi.addComponentHook(this.btn_rep3, "onRollOut");
            this.uiApi.addComponentHook(this.btn_rep4, "onRollOver");
            this.uiApi.addComponentHook(this.btn_rep4, "onRollOut");
            this.uiApi.addComponentHook(this.btn_rep0, "onRelease");
            this.uiApi.addComponentHook(this.btn_rep1, "onRelease");
            this.uiApi.addComponentHook(this.btn_rep2, "onRelease");
            this.uiApi.addComponentHook(this.btn_rep3, "onRelease");
            this.uiApi.addComponentHook(this.btn_rep4, "onRelease");
            this._colorOver = this.sysApi.getConfigEntry("colors.grid.over");
            this.entityDisplayer_npc.setAnimationAndDirection("AnimArtwork", 1);
            this.entityDisplayer_npc.view = "turnstart";
            this.entityDisplayer_npc.look = params[1];
            this.ctr_content.verticalScrollSpeed = 4;
            this._npc = this.dataApi.getNpc(params[0]);
            this._textParams = [];
            if (this.playerApi.getPlayedCharacterInfo().sex == 0)
            {
                this._textParams["m"] = true;
                this._textParams["f"] = false;
            }
            else
            {
                this._textParams["m"] = false;
                this._textParams["f"] = true;
            };
            if (this._npc.gender == 0)
            {
                this._textParams["n"] = true;
                this._textParams["g"] = false;
            }
            else
            {
                this._textParams["n"] = false;
                this._textParams["g"] = true;
            };
            if (params[0] == 1)
            {
                this.lbl_title.text = ((this.dataApi.getTaxCollectorFirstname(params[2]).firstname + " ") + this.dataApi.getTaxCollectorName(params[3]).name);
            }
            else
            {
                if (params[0] == 2141)
                {
                    this.lbl_title.text = this.uiApi.getText("ui.zaap.prism");
                }
                else
                {
                    if (params[0] == 2374)
                    {
                        this.lbl_title.text = this.uiApi.getText("ui.dimension.portal", params[2]);
                    }
                    else
                    {
                        this.lbl_title.text = this._npc.name;
                    };
                    this.lbl_hidden.visible = false;
                    this._aLblReplies = new Array();
                    this._aLblReplies[0] = this.lbl_rep0;
                    this._aLblReplies[1] = this.lbl_rep1;
                    this._aLblReplies[2] = this.lbl_rep2;
                    this._aLblReplies[3] = this.lbl_rep3;
                    this._aLblReplies[4] = this.lbl_rep4;
                    this._aReplies = new Array();
                    this._aReplies[0] = this.btn_rep0;
                    this._aReplies[1] = this.btn_rep1;
                    this._aReplies[2] = this.btn_rep2;
                    this._aReplies[3] = this.btn_rep3;
                    this._aReplies[4] = this.btn_rep4;
                    this._aRepliesIdFromBtn = new Array();
                    if (Roleplay.questions.length > 0)
                    {
                        this.onNpcDialogQuestion(Roleplay.questions[0].messageId, Roleplay.questions[0].dialogParams, Roleplay.questions[0].visibleReplies);
                    };
                };
            };
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
            this.sysApi.enableWorldInteraction();
        }

        private function displayReplies(replies:Object, hasMoreToShow:Boolean=false):void
        {
            var gne:*;
            var rep:*;
            var lbl:*;
            var reply:*;
            var replyId:int;
            var replyTextId:int;
            var posY:int;
            var maxHeight:int = 400;
            var currentRepliesHeight:int;
            this._continueNeeded = hasMoreToShow;
            this._contentHeight = (this.lbl_message.height + 10);
            for (gne in this._aLblReplies)
            {
                this._aReplies[gne].y = 0;
                this._aLblReplies[gne].text = "";
                this._aRepliesIdFromBtn[gne] = 0;
            };
            if (replies.length == 0)
            {
                this._aLblReplies[0].text = this.uiApi.getText("ui.npc.closeDialog");
                currentRepliesHeight = (currentRepliesHeight + (this._aLblReplies[0].height + 5));
                this._aRepliesIdFromBtn[0] = -1;
            };
            var i:uint;
            for each (rep in replies)
            {
                for each (reply in this._npc.dialogReplies)
                {
                    replyId = reply[0];
                    replyTextId = reply[1];
                    if (replyId == rep)
                    {
                        this.lbl_hidden.text = this.uiApi.decodeText(this.uiApi.getTextFromKey(replyTextId), this._textParams);
                        if (i != 0)
                        {
                            this._aReplies[i].state = 0;
                            posY = (this._aReplies[(i - 1)].y + this._aReplies[(i - 1)].height);
                            this._aReplies[i].y = posY;
                        };
                        if (((currentRepliesHeight + this.lbl_hidden.height) + 5) > maxHeight)
                        {
                            hasMoreToShow = true;
                            i++;
                            break;
                        };
                        this._aLblReplies[i].text = this.lbl_hidden.text;
                        currentRepliesHeight = (currentRepliesHeight + (this._aLblReplies[i].height + 5));
                        this._aRepliesIdFromBtn[i] = replyId;
                    };
                };
                i++;
            };
            if (hasMoreToShow)
            {
                this._aReplies[i].state = 0;
                this._aLblReplies[i].text = this.uiApi.getText("ui.npc.showMore");
                this._aReplies[i].y = (this._aReplies[(i - 1)].y + this._aReplies[(i - 1)].height);
                this._aReplies[i].reset();
            }
            else
            {
                if (this._comeBackNeeded)
                {
                    this._aReplies[i].state = 0;
                    this._aLblReplies[i].text = this.uiApi.getText("ui.common.restart");
                    this._aReplies[i].y = (this._aReplies[(i - 1)].y + this._aReplies[(i - 1)].height);
                    this._aReplies[i].reset();
                };
            };
            this._lastAnswerIndex = -1;
            this._currentSelectedAnswer = -1;
            for (lbl in this._aLblReplies)
            {
                this.unselectAnswer(int(lbl));
                if (this._aLblReplies[lbl].text == "")
                {
                    this._aReplies[lbl].state = 0;
                    this._aReplies[lbl].visible = false;
                    this._aReplies[lbl].reset();
                }
                else
                {
                    this._lastAnswerIndex = int(lbl);
                    this._aReplies[lbl].visible = true;
                    this._contentHeight = (this._contentHeight + ((this._aLblReplies[lbl] as Label).contentHeight + 5));
                };
            };
            this.refreshBackground();
        }

        private function showMore():void
        {
            if (this._continueNeeded)
            {
                this._comeBackNeeded = true;
                if (this._moreReplies.length > 4)
                {
                    this.displayReplies(this._moreReplies.slice(0, 4), true);
                    this._moreReplies = this._moreReplies.slice(4);
                }
                else
                {
                    this.displayReplies(this._moreReplies);
                };
            }
            else
            {
                if (this._comeBackNeeded)
                {
                    this._comeBackNeeded = false;
                    this.displayReplies(this._replies.slice(0, 4), true);
                    this._moreReplies = this._replies.slice(4);
                };
            };
        }

        private function selectAnswer(i:int):void
        {
            if (((!(this._aReplies)) || ((this._aReplies.length == 0))))
            {
                return;
            };
            this[("tx_over" + i)].x = this._aReplies[i].x;
            this[("tx_over" + i)].y = this._aReplies[i].y;
            this[("tx_over" + i)].width = this._aReplies[i].width;
            this[("tx_over" + i)].height = this._aReplies[i].height;
            this[("tx_over" + i)].bgColor = this._colorOver;
            this._currentSelectedAnswer = i;
        }

        private function unselectAnswer(i:int):void
        {
            this[("tx_over" + i)].bgColor = -1;
        }

        private function refreshBackground():void
        {
            this.tx_background.height = (this.ctr_content.height + 95);
            this.mainNpcCtr.visible = true;
        }

        public function onRelease(target:Object):void
        {
            if (this._lockAndWaitAnswers)
            {
                return;
            };
            switch (target)
            {
                case this.btn_close:
                    this.sysApi.sendAction(new LeaveDialogRequest());
                    break;
                case this.btn_rep0:
                    if (this._aRepliesIdFromBtn[0])
                    {
                        if (this._aRepliesIdFromBtn[0] >= 0)
                        {
                            this.sysApi.sendAction(new NpcDialogReply(this._aRepliesIdFromBtn[0]));
                            this._lockAndWaitAnswers = true;
                        }
                        else
                        {
                            this.sysApi.sendAction(new LeaveDialogRequest());
                        };
                        this._comeBackNeeded = false;
                    }
                    else
                    {
                        this.showMore();
                    };
                    break;
                case this.btn_rep1:
                    if (this._aRepliesIdFromBtn[1])
                    {
                        this.sysApi.sendAction(new NpcDialogReply(this._aRepliesIdFromBtn[1]));
                        this._lockAndWaitAnswers = true;
                        this._comeBackNeeded = false;
                    }
                    else
                    {
                        this.showMore();
                    };
                    break;
                case this.btn_rep2:
                    if (this._aRepliesIdFromBtn[2])
                    {
                        this.sysApi.sendAction(new NpcDialogReply(this._aRepliesIdFromBtn[2]));
                        this._lockAndWaitAnswers = true;
                        this._comeBackNeeded = false;
                    }
                    else
                    {
                        this.showMore();
                    };
                    break;
                case this.btn_rep3:
                    if (this._aRepliesIdFromBtn[3])
                    {
                        this.sysApi.sendAction(new NpcDialogReply(this._aRepliesIdFromBtn[3]));
                        this._lockAndWaitAnswers = true;
                        this._comeBackNeeded = false;
                    }
                    else
                    {
                        this.showMore();
                    };
                    break;
                case this.btn_rep4:
                    if (this._aRepliesIdFromBtn[4])
                    {
                        this.sysApi.sendAction(new NpcDialogReply(this._aRepliesIdFromBtn[4]));
                        this._lockAndWaitAnswers = true;
                        this._comeBackNeeded = false;
                    }
                    else
                    {
                        this.showMore();
                    };
                    break;
            };
            this.onRollOut(target);
        }

        public function onShortcut(s:String):Boolean
        {
            var answerIndex:int;
            var answerIndex2:int;
            switch (s)
            {
                case "validUi":
                    if (this._currentSelectedAnswer == 0)
                    {
                        if (this._aRepliesIdFromBtn[0])
                        {
                            if (this._aRepliesIdFromBtn[0] >= 0)
                            {
                                this.sysApi.sendAction(new NpcDialogReply(this._aRepliesIdFromBtn[0]));
                                this._lockAndWaitAnswers = true;
                            }
                            else
                            {
                                this.sysApi.sendAction(new LeaveDialogRequest());
                            };
                            this._comeBackNeeded = false;
                        }
                        else
                        {
                            this.showMore();
                        };
                    }
                    else
                    {
                        if (this._currentSelectedAnswer > 0)
                        {
                            if (this._aRepliesIdFromBtn[this._currentSelectedAnswer])
                            {
                                this.sysApi.sendAction(new NpcDialogReply(this._aRepliesIdFromBtn[this._currentSelectedAnswer]));
                                this._lockAndWaitAnswers = true;
                                this._comeBackNeeded = false;
                            }
                            else
                            {
                                this.showMore();
                            };
                        };
                    };
                    return (true);
                case "closeUi":
                    this.sysApi.sendAction(new LeaveDialogRequest());
                    return (true);
                case "upArrow":
                    if (this._lastAnswerIndex == -1)
                    {
                        return (false);
                    };
                    if (this._currentSelectedAnswer == -1)
                    {
                        this.selectAnswer(this._lastAnswerIndex);
                    }
                    else
                    {
                        this.unselectAnswer(this._currentSelectedAnswer);
                        answerIndex = (this._currentSelectedAnswer - 1);
                        if (answerIndex < 0)
                        {
                            answerIndex = this._lastAnswerIndex;
                        };
                        this.selectAnswer(answerIndex);
                    };
                    return (true);
                case "downArrow":
                    if (this._lastAnswerIndex == -1)
                    {
                        return (false);
                    };
                    if (this._currentSelectedAnswer == -1)
                    {
                        this.selectAnswer(0);
                    }
                    else
                    {
                        this.unselectAnswer(this._currentSelectedAnswer);
                        answerIndex2 = (this._currentSelectedAnswer + 1);
                        if (answerIndex2 > this._lastAnswerIndex)
                        {
                            answerIndex2 = 0;
                        };
                        this.selectAnswer(answerIndex2);
                    };
                    return (true);
            };
            return (false);
        }

        public function onRollOver(target:Object):void
        {
            var i:int;
            if (target.name.indexOf("btn_rep") != -1)
            {
                i = int(target.name.substr(7, 1));
                this.selectAnswer(i);
            };
        }

        public function onRollOut(target:Object):void
        {
            var i:int;
            if (target.name.indexOf("btn_rep") != -1)
            {
                i = int(target.name.substr(7, 1));
                this.unselectAnswer(i);
            };
        }

        public function onNpcDialogQuestion(messageId:uint=0, dialogParams:Object=null, visibleReplies:Object=null):void
        {
            var param:String;
            var lbl:*;
            var msg:*;
            var msgId:int;
            var msgTextId:int;
            var messagenpc:String;
            var rep:*;
            this._replies = new Array();
            this._moreReplies = new Array();
            this._lockAndWaitAnswers = false;
            var params:Array = new Array();
            for each (param in dialogParams)
            {
                params.push(param);
            };
            this._currentMsg = messageId;
            for each (lbl in this._aLblReplies)
            {
                lbl.text = "";
            };
            for each (msg in this._npc.dialogMessages)
            {
                msgId = msg[0];
                msgTextId = msg[1];
                if (msgId == messageId)
                {
                    messagenpc = this.uiApi.decodeText(this.utilApi.getTextWithParams(msgTextId, params, "#"), this._textParams);
                    this.lbl_message.text = messagenpc;
                    for each (rep in visibleReplies)
                    {
                        this._replies.push(rep);
                    };
                    this.repliesContainer.x = (this.lbl_message.x + 20);
                    this.repliesContainer.y = ((this.lbl_message.y + 15) + this.lbl_message.height);
                    if (this._replies.length > 5)
                    {
                        this.displayReplies(this._replies.slice(0, 4), true);
                        this._moreReplies = this._replies.slice(4);
                    }
                    else
                    {
                        this.displayReplies(this._replies);
                    };
                };
            };
            this.ctr_content.height = this._contentHeight;
            if (this.ctr_content.height > 550)
            {
                this.ctr_content.height = 550;
            };
            this.ctr_content.finalize();
            this.refreshBackground();
        }

        public function onTaxCollectorDialogQuestionExtended(guildName:String, maxPods:uint, prospecting:uint, wisdom:uint, taxCollectorsCount:uint, taxCollectorAttack:int, kamas:int, experience:int, pods:int, itemsValue:int):void
        {
            this.onAllianceTaxCollectorDialogQuestionExtended(guildName, maxPods, prospecting, wisdom, taxCollectorsCount, taxCollectorAttack, kamas, experience, pods, itemsValue);
        }

        public function onAllianceTaxCollectorDialogQuestionExtended(guildName:String, maxPods:uint, prospecting:uint, wisdom:uint, taxCollectorsCount:uint, taxCollectorAttack:int, kamas:int, experience:int, pods:int, itemsValue:int, alliance:BasicNamedAllianceInformations=null):void
        {
            var msg:*;
            var msgId:int;
            var msgTextId:int;
            var allianceName:String;
            var allianceTag:String;
            if (this.sysApi.getCurrentServer().gameTypeId == 1)
            {
                if (pods == 0)
                {
                    if (alliance)
                    {
                        this._currentMsg = 18063;
                    }
                    else
                    {
                        this._currentMsg = 18064;
                    };
                }
                else
                {
                    if (alliance)
                    {
                        this._currentMsg = 18065;
                    }
                    else
                    {
                        this._currentMsg = 18066;
                    };
                };
            }
            else
            {
                if (alliance)
                {
                    this._currentMsg = 15427;
                }
                else
                {
                    this._currentMsg = 1;
                };
            };
            for each (msg in this._npc.dialogMessages)
            {
                msgId = msg[0];
                msgTextId = msg[1];
                if (msgId == this._currentMsg)
                {
                    if ((((((this._currentMsg == 15427)) || ((this._currentMsg == 18063)))) || ((this._currentMsg == 18065))))
                    {
                        allianceName = alliance.allianceName;
                        if (allianceName == "#NONAME#")
                        {
                            allianceName = this.uiApi.getText("ui.guild.noName");
                        };
                        allianceTag = alliance.allianceTag;
                        if (allianceTag == "#TAG#")
                        {
                            allianceTag = this.uiApi.getText("ui.alliance.noTag");
                        };
                        if (this._currentMsg == 15427)
                        {
                            this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", guildName, maxPods, prospecting, wisdom, taxCollectorsCount, this.utilApi.kamasToString(kamas, ""), this.utilApi.kamasToString(experience, ""), this.utilApi.kamasToString(pods, ""), this.utilApi.kamasToString(itemsValue, ""), allianceName, (("[" + allianceTag) + "]"));
                        }
                        else
                        {
                            if (this._currentMsg == 18065)
                            {
                                this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", guildName, maxPods, prospecting, wisdom, taxCollectorsCount, this.utilApi.kamasToString(pods, ""), this.utilApi.kamasToString(itemsValue, ""), allianceName, (("[" + allianceTag) + "]"));
                            }
                            else
                            {
                                if (this._currentMsg == 18063)
                                {
                                    this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", guildName, maxPods, prospecting, wisdom, taxCollectorsCount, allianceName, (("[" + allianceTag) + "]"));
                                };
                            };
                        };
                    }
                    else
                    {
                        if (this._currentMsg == 1)
                        {
                            this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", guildName, maxPods, prospecting, wisdom, taxCollectorsCount, this.utilApi.kamasToString(kamas, ""), this.utilApi.kamasToString(experience, ""), this.utilApi.kamasToString(pods, ""), this.utilApi.kamasToString(itemsValue, ""));
                        }
                        else
                        {
                            if (this._currentMsg == 18066)
                            {
                                this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", guildName, maxPods, prospecting, wisdom, taxCollectorsCount, this.utilApi.kamasToString(pods, ""), this.utilApi.kamasToString(itemsValue, ""));
                            }
                            else
                            {
                                if (this._currentMsg == 18064)
                                {
                                    this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", guildName, maxPods, prospecting, wisdom, taxCollectorsCount);
                                };
                            };
                        };
                    };
                    if (taxCollectorAttack > 0)
                    {
                        this.lbl_message.text = (this.lbl_message.text + ("\n\n" + this.uiApi.processText(this.uiApi.getText("ui.social.taxCollectorWaitBeforeAttack", taxCollectorAttack), "m", (taxCollectorAttack <= 1))));
                    }
                    else
                    {
                        if (taxCollectorAttack < 0)
                        {
                            this.lbl_message.text = (this.lbl_message.text + ("\n\n" + this.uiApi.getText("ui.social.taxCollectorNoAttack")));
                        };
                    };
                };
            };
            this._contentHeight = (this.lbl_message.height + 10);
            this.ctr_content.height = this._contentHeight;
            if (this.ctr_content.height > 550)
            {
                this.ctr_content.height = 550;
                this.ctr_content.finalize();
            };
            this.refreshBackground();
        }

        public function onTaxCollectorDialogQuestionBasic(guildName:String):void
        {
            var msg:*;
            var msgId:int;
            var msgTextId:int;
            this._currentMsg = 2;
            for each (msg in this._npc.dialogMessages)
            {
                msgId = msg[0];
                msgTextId = msg[1];
                if (msgId == this._currentMsg)
                {
                    this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", guildName);
                };
            };
            this._contentHeight = (this.lbl_message.height + 10);
            this.ctr_content.height = this._contentHeight;
            if (this.ctr_content.height > 550)
            {
                this.ctr_content.height = 550;
                this.ctr_content.finalize();
            };
            this.refreshBackground();
        }

        public function onAlliancePrismDialogQuestion():void
        {
            var msg:*;
            var msgId:int;
            var msgTextId:int;
            var vulneStart:String;
            this._currentMsg = 15428;
            var subAreaId:int = this.playerApi.currentSubArea().id;
            var prism:PrismSubAreaWrapper = this.socialApi.getPrismSubAreaById(subAreaId);
            var alliance:AllianceWrapper = prism.alliance;
            if (!(alliance))
            {
                alliance = this.socialApi.getAlliance();
            };
            for each (msg in this._npc.dialogMessages)
            {
                msgId = msg[0];
                msgTextId = msg[1];
                if (msgId == this._currentMsg)
                {
                    vulneStart = ((this.timeApi.getDate((prism.nextVulnerabilityDate * 1000)) + " ") + this.timeApi.getClock((prism.nextVulnerabilityDate * 1000)));
                    this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", alliance.allianceName, this.uiApi.getText(("ui.prism.state" + prism.state)), vulneStart, this.utilApi.kamasToString(prism.rewardTokenCount, ""));
                };
            };
            this._contentHeight = (this.lbl_message.height + 10);
            this.ctr_content.height = this._contentHeight;
            if (this.ctr_content.height > 550)
            {
                this.ctr_content.height = 550;
                this.ctr_content.finalize();
            };
            this.refreshBackground();
        }

        public function onPortalDialogQuestion(availableUseLeft:int, durationBeforeClosure:Number):void
        {
            var msg:*;
            var msgId:int;
            var msgTextId:int;
            var timeLeftBeforeClosure:String;
            for each (msg in this._npc.dialogMessages)
            {
                msgId = msg[0];
                msgTextId = msg[1];
                timeLeftBeforeClosure = this.timeApi.getDuration(durationBeforeClosure);
                this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId, "#", availableUseLeft, timeLeftBeforeClosure);
                break;
            };
            this._contentHeight = (this.lbl_message.height + 10);
            this.ctr_content.height = this._contentHeight;
            if (this.ctr_content.height > 550)
            {
                this.ctr_content.height = 550;
                this.ctr_content.finalize();
            };
            this.refreshBackground();
        }

        private function onLeaveDialog():void
        {
            this.uiApi.unloadUi(this.uiApi.me().name);
        }


    }
}//package ui

