'use strict';

import riot from 'riot'
import MessageStore from '../components/MessageStore.js';

import '../components/Client.tag'
import '../components/Command.tag'
import '../components/Screen.tag'

import '../js/lib/linkify'
import '../js/lib/linkify-html'

riot.messageStore = new MessageStore()
riot.mount('*')
