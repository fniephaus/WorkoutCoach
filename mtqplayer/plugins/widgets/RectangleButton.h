#pragma once

#include <QSvgRenderer>

#include "BaseWidget.h"

class RectangleButton: public BaseWidget
{
	//Tell the Qt-Preprocessor this is a QObject
	Q_OBJECT

	//Register widget as plugin for use in QML
	MTQ_QML_PLUGIN_REGISTRATION(RectangleButton, "widgets")

	//QProperties: access attributes from QML.
	//Here we define the getters and setters to be used
	Q_PROPERTY(QColor background READ background WRITE setBackground NOTIFY backgroundChanged)
	Q_PROPERTY(bool active READ active WRITE setActive NOTIFY activeChanged)

public:
	RectangleButton(QQuickItem *parent = 0);
	RectangleButton(QQuickItem *parent, const QColor background);

	void paint(QPainter *painter);

	QColor background() const;
	void setBackground(const QColor background);
	bool active() const;
	void setActive(const bool state);

private:
	QColor m_background;
	bool m_active;

protected:
	void processTapDown(mtq::TapEvent *event);
	void processTapUp(mtq::TapEvent *event);
	void processTapCancel(mtq::TapEvent *event);

signals:
	void pressed();
	void backgroundChanged(QColor background);
	void activeChanged(bool active);

};
