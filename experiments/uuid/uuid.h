/**
   Copyright (c) 1990- 1993, 1996 Open Software Foundation, Inc.
   Copyright (c) 1989 by Hewlett-Packard Company, Palo Alto, Ca. &
   Digital Equipment Corporation, Maynard, Mass.
   Copyright (c) 1998 Microsoft.
   To anyone who acknowledges that this file is provided "AS IS"
   without any express or implied warranty: permission to use, copy,
   modify, and distribute this file for any purpose is hereby
   granted without fee, provided that the above copyright notices and
   this notice appears in all source code copies, and that none of
   the names of Open Software Foundation, Inc., Hewlett-Packard
   Company, Microsoft, or Digital Equipment Corporation be used in
   advertising or publicity pertaining to distribution of the software
   without specific, written prior permission. Neither Open Software
   Foundation, Inc., Hewlett-Packard Company, Microsoft, nor Digital
   Equipment Corporation makes any representations about the
   suitability of this software for any purpose.
**/

#ifndef __UUID_H__
#define __UUID_H__

#include "sysdep.h"
#include <arpa/inet.h>

#undef uuid_t
typedef struct {
    unsigned32  time_low;
    unsigned16  time_mid;
    unsigned16  time_hi_and_version;
    unsigned8   clock_seq_hi_and_reserved;
    unsigned8   clock_seq_low;
    byte        node[6];
} uuid_t;

/* uuid_create -- generate a UUID */
int uuid_create(uuid_t * uuid);
/* from uuid struct to uuid string */
void make_buff_uuid(uuid_t u, char* buff_uuid);

#endif
