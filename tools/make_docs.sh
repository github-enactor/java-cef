#!/bin/bash
# Copyright (c) 2013 The Chromium Embedded Framework Authors. All rights
# reserved. Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file.

DIR="$( cd "$( dirname "$0" )" && cd .. && pwd )"
OUT_PATH="${DIR}/out/docs"

# --ignore-source-errors is a JDK 9+ javadoc option. Building on JDK 8 (e.g. the
# macOS JCEF build, which links the native lib against a JDK 8 JRE) makes javadoc
# reject it as an invalid flag and abort, so out/docs is never produced. Pass the
# flag only when the local javadoc advertises it: JDK 9+ keeps the source-error
# tolerance, JDK 8 still generates docs (javadoc 8 is lenient about source errors
# anyway).
IGNORE_SOURCE_ERRORS=""
if javadoc --help 2>&1 | grep -q -- '--ignore-source-errors'; then
  IGNORE_SOURCE_ERRORS="--ignore-source-errors"
fi

javadoc $IGNORE_SOURCE_ERRORS -Xdoclint:none -windowtitle "CEF3 Java API Docs" -footer "<center><a href="https://github.com/chromiumembedded/java-cef" target="_top">Chromium Embedded Framework (CEF)</a> Copyright &copy 2013 Marshall A. Greenblatt</center>" -nodeprecated -d "$OUT_PATH" -sourcepath "${DIR}/java" -link http://docs.oracle.com/javase/7/docs/api/ -subpackages org.cef

