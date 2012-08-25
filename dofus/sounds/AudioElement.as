// Action script...

// [Initial MovieClip Action of sprite 20710]
#initclip 231
if (!dofus.sounds.AudioElement)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.sounds)
    {
        _global.dofus.sounds = new Object();
    } // end if
    var _loc1 = (_global.dofus.sounds.AudioElement = function (uniqID, file, linkedClip, streaming)
    {
        if (uniqID == undefined)
        {
            return;
        } // end if
        if (file == undefined)
        {
            return;
        } // end if
        if (linkedClip == undefined)
        {
            return;
        } // end if
        this._nUniqID = uniqID;
        this._mcLinkedClip = linkedClip;
        this._sFile = file;
        this._bStreaming = streaming != undefined ? (streaming) : (false);
        super(linkedClip);
        this._bLoading = true;
        if (dofus.Constants.USING_PACKED_SOUNDS)
        {
            super.attachSound(file.substr(3));
            this.onLoad(true);
        }
        else
        {
            super.loadSound(file, this._bStreaming);
        } // end else if
    }).prototype;
    _loc1.__get__uniqID = function ()
    {
        return (this._nUniqID);
    };
    _loc1.__get__linkedClip = function ()
    {
        return (this._mcLinkedClip);
    };
    _loc1.__get__file = function ()
    {
        return (this._sFile);
    };
    _loc1.__get__streaming = function ()
    {
        return (this._bStreaming);
    };
    _loc1.__get__volume = function ()
    {
        return (super.getVolume());
    };
    _loc1.__set__volume = function (nValue)
    {
        if (nValue < 0 || nValue > 100)
        {
            return;
        } // end if
        if (!this._bMute && super.setVolume != undefined)
        {
            super.setVolume(nValue);
        }
        else if (super.setVolume != undefined)
        {
            super.setVolume(0);
            this._nVolumeBeforeMute = nValue;
        } // end else if
        //return (this.volume());
    };
    _loc1.__get__mute = function ()
    {
        return (this._bMute);
    };
    _loc1.__set__mute = function (bValue)
    {
        this._bMute = bValue;
        if (this._bMute && super.setVolume != undefined)
        {
            this._nVolumeBeforeMute = this.volume;
            super.setVolume(0);
        }
        else if (super.setVolume != undefined)
        {
            if (this._nVolumeBeforeMute > 0)
            {
                super.setVolume(this._nVolumeBeforeMute);
            } // end if
        } // end else if
        //return (this.mute());
    };
    _loc1.__get__loops = function ()
    {
        return (this._nLoops);
    };
    _loc1.__set__loops = function (nValue)
    {
        if (nValue < dofus.sounds.AudioElement.ONESHOT_SAMPLE || nValue > dofus.sounds.AudioElement.INFINITE_LOOP)
        {
            return;
        } // end if
        this._nLoops = nValue;
        //return (this.loops());
    };
    _loc1.__get__offset = function ()
    {
        return (this._nOffset);
    };
    _loc1.__set__offset = function (nValue)
    {
        if (nValue < 0 || this._nMaxLength != null && nValue > this._nMaxLength)
        {
            return;
        } // end if
        this._nOffset = nValue;
        //return (this.offset());
    };
    _loc1.__get__maxLength = function ()
    {
        return (this._nMaxLength);
    };
    _loc1.__set__maxLength = function (nValue)
    {
        if (nValue < 0)
        {
            return;
        } // end if
        this._nMaxLength = nValue;
        //return (this.maxLength());
    };
    _loc1.dispose = function (Void)
    {
        this.onKill();
        this._mcLinkedClip.onEnterFrame = null;
        delete this._mcLinkedClip.onEnterFrame;
        this._mcLinkedClip.unloadMovie();
        this._mcLinkedClip.removeMovieClip();
        delete this._mcLinkedClip;
    };
    _loc1.getVolume = function ()
    {
        return (this.volume);
    };
    _loc1.setVolume = function (nVolume)
    {
        this.volume = nVolume;
    };
    _loc1.startElement = function ()
    {
        if (this._bStreaming && !this._bLoading || !this._bStreaming && !this._bLoaded)
        {
            this._bStartWhenLoaded = true;
        }
        else
        {
            if (this._nMaxLength != dofus.sounds.AudioElement.UNLIMITED_LENGTH)
            {
                _global.clearInterval(this._nKillTimer);
                this._nKillTimer = _global.setInterval(this, this.onKill, this._nMaxLength * 1000);
            } // end if
            super.start(this._nOffset, this._nLoops);
        } // end else if
    };
    _loc1.stop = function ()
    {
        super.stop();
    };
    _loc1.fadeOut = function (nDuration, bAutoDestroy)
    {
        var volume = this.volume;
        var t = volume / nDuration / dofus.Constants.AVERAGE_FRAMES_PER_SECOND;
        var parentElement = this;
        var parent = super;
        var myself = this._mcLinkedClip;
        var destroy = bAutoDestroy;
        this._mcLinkedClip.onEnterFrame = function ()
        {
            volume = volume - t;
            parent.setVolume(volume);
            if (volume <= 0)
            {
                parentElement.stop();
                myself.onEnterFrame = undefined;
                delete myself.onEnterFrame;
                if (destroy)
                {
                    parentElement.dispose();
                } // end if
            } // end if
        };
    };
    _loc1.toString = function ()
    {
        var _loc2 = "[AudioElement = " + this._nUniqID + "]\n";
        _loc2 = _loc2 + (" > Linked clip  : " + this._mcLinkedClip + "\n");
        _loc2 = _loc2 + (" > File         : " + this._sFile + "\n");
        _loc2 = _loc2 + (" > Loops        : " + this._nLoops + "\n");
        _loc2 = _loc2 + (" > Start offset : " + this._nOffset + "\n");
        _loc2 = _loc2 + (" > Max length   : " + this._nMaxLength + "\n");
        _loc2 = _loc2 + (" > Base vol.    : " + this.baseVolume + "\n");
        _loc2 = _loc2 + (" > Volume       : " + this.getVolume() + "\n");
        _loc2 = _loc2 + (" > Mute         : " + this._bMute + "\n");
        return (_loc2);
    };
    _loc1.onLoad = function (bSuccess)
    {
        if (!bSuccess)
        {
            return;
        } // end if
        this._bLoaded = true;
        if (this._bStartWhenLoaded)
        {
            this.startElement();
        } // end if
    };
    _loc1.onSoundComplete = function ()
    {
        this.dispose();
    };
    _loc1.onKill = function ()
    {
        _global.clearInterval(this._nKillTimer);
        this.stop();
    };
    _loc1.addProperty("mute", _loc1.__get__mute, _loc1.__set__mute);
    _loc1.addProperty("volume", _loc1.__get__volume, _loc1.__set__volume);
    _loc1.addProperty("uniqID", _loc1.__get__uniqID, function ()
    {
    });
    _loc1.addProperty("streaming", _loc1.__get__streaming, function ()
    {
    });
    _loc1.addProperty("maxLength", _loc1.__get__maxLength, _loc1.__set__maxLength);
    _loc1.addProperty("loops", _loc1.__get__loops, _loc1.__set__loops);
    _loc1.addProperty("linkedClip", _loc1.__get__linkedClip, function ()
    {
    });
    _loc1.addProperty("file", _loc1.__get__file, function ()
    {
    });
    _loc1.addProperty("offset", _loc1.__get__offset, _loc1.__set__offset);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.sounds.AudioElement = function (uniqID, file, linkedClip, streaming)
    {
        if (uniqID == undefined)
        {
            return;
        } } // end if
        if (file == undefined)
        {
            return;
        } } // end if
        if (linkedClip == undefined)
        {
            return;
        } } // end if
        this._nUniqID = uniqID;
        this._mcLinkedClip = linkedClip;
        this._sFile = file;
        this._bStreaming = streaming != undefined ? (streaming) : (false);
        super(linkedClip);
        this._bLoading = true;
        if (dofus.Constants.USING_PACKED_SOUNDS)
        {
            super.attachSound(file.substr(3));
            this.onLoad(true);
        }
        else
        {
            super.loadSound(file, this._bStreaming);
        } } // end else if
    }).INFINITE_LOOP = 999999;
    (_global.dofus.sounds.AudioElement = function (uniqID, file, linkedClip, streaming)
    {
        if (uniqID == undefined)
        {
            return;
        } } } // end if
        if (file == undefined)
        {
            return;
        } } } // end if
        if (linkedClip == undefined)
        {
            return;
        } } } // end if
        this._nUniqID = uniqID;
        this._mcLinkedClip = linkedClip;
        this._sFile = file;
        this._bStreaming = streaming != undefined ? (streaming) : (false);
        super(linkedClip);
        this._bLoading = true;
        if (dofus.Constants.USING_PACKED_SOUNDS)
        {
            super.attachSound(file.substr(3));
            this.onLoad(true);
        }
        else
        {
            super.loadSound(file, this._bStreaming);
        } } } // end else if
    }).ONESHOT_SAMPLE = 1;
    (_global.dofus.sounds.AudioElement = function (uniqID, file, linkedClip, streaming)
    {
        if (uniqID == undefined)
        {
            return;
        } } } } // end if
        if (file == undefined)
        {
            return;
        } } } } // end if
        if (linkedClip == undefined)
        {
            return;
        } } } } // end if
        this._nUniqID = uniqID;
        this._mcLinkedClip = linkedClip;
        this._sFile = file;
        this._bStreaming = streaming != undefined ? (streaming) : (false);
        super(linkedClip);
        this._bLoading = true;
        if (dofus.Constants.USING_PACKED_SOUNDS)
        {
            super.attachSound(file.substr(3));
            this.onLoad(true);
        }
        else
        {
            super.loadSound(file, this._bStreaming);
        } } } } // end else if
    }).UNLIMITED_LENGTH = 0;
    _loc1._nVolumeBeforeMute = -1;
} // end if
#endinitclip
