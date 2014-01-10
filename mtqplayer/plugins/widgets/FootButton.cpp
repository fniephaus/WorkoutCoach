#include "FootButton.h"

#include <QPainter>

#include "Design.h"

using namespace mtq;

//We need to register this Type in MTQ
MTQ_QML_REGISTER_PLUGIN(FootButton)

FootButton::FootButton(QQuickItem *parent)
	: BaseWidget(parent),
	  m_active(false),
	  m_type("left"),
	  m_svgRenderer(new QSvgRenderer(design::feetSvgFile, this))
{
	setHeight(380);
	setWidth(190);
}

//This is the painting method. It paints the FootButton using the QPainter painter
void FootButton::paint(QPainter *painter)
{
	// Render SVG
	if (m_type == "left") {
		m_svgRenderer->render(painter, "FootLeft::white", QRect(0, 0, width(), height()));
	} else {
		m_svgRenderer->render(painter, "FootRight::white", QRect(0, 0, width(), height()));
	}
}

void FootButton::processTapDown(mtq::TapEvent *event)
{
	setActive(true);
	emit pressed();
}

void FootButton::processTapUp(mtq::TapEvent *event)
{
	setActive(false);
}

void FootButton::processTapCancel(mtq::TapEvent *event)
{
	setActive(false);
}

bool FootButton::active() const
{
	return m_active;
}

void FootButton::setActive(const bool state)
{
	m_active = state;
	update();
}

QString FootButton::type()
{
	return m_type;
}

void FootButton::setType(QString type)
{
	m_type = type;
	update();
}
