#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=obj
DEBUGGABLE_SUFFIX=obj
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=obj
DEBUGGABLE_SUFFIX=obj
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=Aula13_10.Asm Aula20_10.asm Aula25_10.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/Aula13_10.o ${OBJECTDIR}/Aula20_10.obj ${OBJECTDIR}/Aula25_10.obj
POSSIBLE_DEPFILES=${OBJECTDIR}/Aula13_10.o.d ${OBJECTDIR}/Aula20_10.obj.d ${OBJECTDIR}/Aula25_10.obj.d

# Object Files
OBJECTFILES=${OBJECTDIR}/Aula13_10.o ${OBJECTDIR}/Aula20_10.obj ${OBJECTDIR}/Aula25_10.obj

# Source Files
SOURCEFILES=Aula13_10.Asm Aula20_10.asm Aula25_10.asm

# Pack Options 
PACK_ASSEMBLER_OPTIONS=-I "${DFP_DIR}/avrasm/inc"  -i m328Pdef.inc



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/Aula13_10.o: Aula13_10.Asm  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Aula13_10.o 
	${MP_AS}  -fI -W+ie ${PACK_ASSEMBLER_OPTIONS} -d dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -m dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.map  -S dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.tmp Aula13_10.Asm
${OBJECTDIR}/Aula20_10.obj: Aula20_10.asm  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Aula20_10.obj 
	${MP_AS}  -fI -W+ie ${PACK_ASSEMBLER_OPTIONS} -d dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -m dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.map  -S dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.tmp Aula20_10.asm
${OBJECTDIR}/Aula25_10.obj: Aula25_10.asm  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Aula25_10.obj 
	${MP_AS}  -fI -W+ie ${PACK_ASSEMBLER_OPTIONS} -d dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -m dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.map  -S dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.tmp Aula25_10.asm
else
${OBJECTDIR}/Aula13_10.o: Aula13_10.Asm  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Aula13_10.o 
	${MP_AS}  -fI -W+ie ${PACK_ASSEMBLER_OPTIONS} -d dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -S dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.tmp  -o dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.hex  -m dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.map  -l dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.lss Aula13_10.Asm
${OBJECTDIR}/Aula20_10.obj: Aula20_10.asm  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Aula20_10.obj 
	${MP_AS}  -fI -W+ie ${PACK_ASSEMBLER_OPTIONS} -d dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -S dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.tmp  -o dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.hex  -m dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.map  -l dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.lss Aula20_10.asm
${OBJECTDIR}/Aula25_10.obj: Aula25_10.asm  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/Aula25_10.obj 
	${MP_AS}  -fI -W+ie ${PACK_ASSEMBLER_OPTIONS} -d dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  -S dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.tmp  -o dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.hex  -m dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.map  -l dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.lss Aula25_10.asm
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/projetoMPLAB.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
