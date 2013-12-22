#include "FeetButton.h"

#include <QPainter>

#include "Design.h"

using namespace mtq;

//We need to register this Type in MTQ
MTQ_QML_REGISTER_PLUGIN(FeetButton)

FeetButton::FeetButton(QQuickItem *parent)
	: BaseWidget(parent),
	  m_active(false),
	  m_svgRenderer(new QSvgRenderer(design::feetSvgFile, this))
{
	setHeight(400);
	setWidth(400);
}

//This is the painting method. It paints the FeetButton using the QPainter painter
void FeetButton::paint(QPainter *painter)
{
	// Render SVG
	m_svgRenderer->render(painter, "Feet::white", QRect(0, 0, width(), height()));
}

void FeetButton::processTapDown(mtq::TapEvent *event)
{
	setActive(true);
	emit pressed();
}

void FeetButton::processTapUp(mtq::TapEvent *event)
{
	setActive(false);
}

void FeetButton::processTapCancel(mtq::TapEvent *event)
{
	setActive(false);
}

bool FeetButton::active() const
{
	return m_active;
}

void FeetButton::setActive(const bool state)
{
	m_active = state;
	update();
}
